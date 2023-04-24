import React, { useEffect, useState, useCallback } from 'react';
import Web3 from 'web3';
import './App.css';
import detectEthereumProvider from '@metamask/detect-provider';
import { loadContract } from './utils/load-contract';

function App() {
  const [web3Api, setWeb3Api] = useState({
    provider: null,
    isProviderLoaded: false,
    web3: null,
    contract: null,
  });
  const [account, setAccounts] = useState(null);
  const [balance, setBalance] = useState(null);
  const [reload, setReload] = useState(false);

  const contractConnected = account && web3Api.contract

  const reloadEffect = useCallback(() => setReload(!reload), [reload]);
  const setAccountListener = (provider) => {
    provider.on('accountsChanged', (_) => window.location.reload());
    provider.on('chainChanged', (_) => window.location.reload());
  };
  useEffect(() => {
    const loadProvider = async () => {
      const provider = await detectEthereumProvider();
     

      if (provider) {
         const contract = await loadContract('Faucet', provider);
        setAccountListener(provider);
        setWeb3Api({
          web3: new Web3(provider),
          provider,
          contract,
          isProviderLoaded: true,
        });
      } else {
       // setWeb3Api({ ...web3Api, isProviderLoaded: true });
        setWeb3Api(api => ({...api, isProviderLoaded: true}))
        console.error('Please install Metamask');
      }
    };
    loadProvider();
  }, []);

  useEffect(() => {
    // only gets executed if there is an object in web3Api.web3
    // use && moving forward !
    const getAccounts = async () => {
      const accounts = await web3Api.web3.eth.getAccounts();
      setAccounts(accounts[0]);
    };
    web3Api.web3 && getAccounts();
  }, [web3Api.web3]);

  useEffect(() => {
    const loadBalance = async () => {
      const { contract, web3 } = web3Api;
      const balance = await web3.eth.getBalance(contract.address);

      const ethBalance = web3.utils.fromWei(balance, 'ether');

      setBalance(ethBalance);
    };
    web3Api.contract && loadBalance();
  }, [web3Api, reload]);



  const addFunds = useCallback(async () => {
    const { contract } = web3Api;
    await contract.addFunds({
      from: account,
      value: Web3.utils.toWei('1', 'ether'),
    });

    reloadEffect();
  }, [web3Api, account, reloadEffect]);

  const withDrawFunds = async () => {
    const { contract } = web3Api;
    const withdrawAmount = Web3.utils.toWei('0.1', 'ether');
    await contract.withdraw(withdrawAmount, {
      from: account,
    });
    reloadEffect();
  };

  return (
    <>
      <div className="faucet-wrapper">
        <div className="faucet">
          {web3Api.isProviderLoaded ? (
            <div className="is-flex is-align-items-center">
              <div className="mr-2">
                <strong>Account: </strong>
              </div>
              {account ? (
                <div> {account}</div>
              ) : !web3Api.provider ? (
                <>
                  <div className="notification is-warning is-size-5 is-rounded">
                    Wallect is not detected!{' '}
                    <a
                      rel="noreferrer"
                      target="_blank"
                      href="https://docs.metamask.io"
                    >
                      Install Metamask
                    </a>
                  </div>
                </>
              ) : (
                <button
                  onClick={() =>
                    web3Api.provider.request({ method: 'eth_requestAccounts' })
                  }
                  className="button is-small is-primary ml-2"
                >
                  Connect Wallet
                </button>
              )}
            </div>
          ) : (
            <span>Looking for Web3 ... </span>
          )}
          <div className="balance-view is-size-2 my-2">
            Current Balance: <strong>{balance}</strong> ETH
          </div>
          {!contractConnected && 
          <i className='is-block'>
            Connect to Ganache
          </i>
          }

          <button
            disabled={!contractConnected}
            onClick={addFunds}
            className="button is-link mr-2"
          >
            Donate 
          </button>
          <button
            disabled={!contractConnected}
            onClick={withDrawFunds}
            className="button is-primary"
          >
            Withdraw
          </button>
        </div>
      </div>
    </>
  );
}

export default App;
