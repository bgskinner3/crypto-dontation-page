// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


//abstract contract applys function implementation 
// It's a way for desginer to say that 
// "any chuild of this abstract contract has to implement specified methods"
abstract contract Logger {

  function emitLog() public pure virtual returns(bytes32);

  
  
}