// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// these functions can only be inherited from other interfaces
// they cannot be inherited from other smart contracts

// they cannot declare a contructor
// they cannot ccannot decclare stat vraibles
// all functions must be external

interface IFaucet {
    function addFunds() external payable;
    function withdraw(uint withdrawAmount) external;
}
