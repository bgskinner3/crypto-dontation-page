// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./Owned.sol";
import "./Logger.sol";
import "./IFaucet.sol";

contract Faucet is Owned, Logger, IFaucet {
    uint public numOfFunders;

    mapping(address => bool) private funders;
    mapping(uint => address) private lutFunders;

    constructor() {
        owner = msg.sender;
    }

    // modifier to inject withdraw limit
    modifier limitWithdraw(uint withdrawAmount) {
        require(
            withdrawAmount <= 1000000000000000000,
            "Cannot withdraw more than 1 ether"
        );
        _;
    }

    receive() external payable {}

    function emitLog() public pure override returns (bytes32) {
        return "Hello";
    }

    //adding ether into smart contract
    function addFunds() external payable override {
        address funder = msg.sender;

        if (!funders[funder]) {
            uint index = numOfFunders++;
            funders[funder] = true;
            lutFunders[index] = funder;
        }
    }

    function test1() external onlyOwner {
        // admin function test onyl admin can ahve access
    }

    function withdraw(uint withdrawAmount)
        external
        override
        limitWithdraw(withdrawAmount)
    {
        payable(msg.sender).transfer(withdrawAmount);
    }

    function getAllFunders() external view returns (address[] memory) {
        address[] memory _funders = new address[](numOfFunders);

        for (uint i = 0; i < numOfFunders; i++) {
            _funders[i] = lutFunders[i];
        }

        return _funders;
    }

    function getFunderAtIndex(uint8 index) external view returns (address) {
        return lutFunders[index];
    }
}

/**

const instance = await Faucet.deployed()

instance.withdraw("500000000000000000", {from: accounts[1]})
instance.withdraw("1000000000000000000", {from: accounts[2]})
instance.withdraw("2000000000000000000", {from: accounts[1]})

instance.addFunds({from: accounts[0], value: "500000000000000000"})
instance.addFunds({from: accounts[1], value: "1000000000000000000"})
instance.addFunds({from: accounts[3], value: "4000000000000000000"})
instance.getFunderAtIndex(0)


instance.getAllFunders()
 */
