// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Storage {
  uint8 public a =7; // can only take one byte
  uint16 public b = 10; // can take 2 bytes
  address public c = 0xB899Ca36F6EF67995D2c3a94De5f7726dF2a452E; // can take 20 bytes
  bool d = true ; // 1 byte
  uint64 public e = 15; // 8 bytes
  // abiove breaks down to 32 bytes and all values will be stored in slot 0

  uint256 public f = 200; // 32 bytes -> stored solt 1
  uint8 public g = 40; // 1 byte -> stored in slot 2
  uint256 public h = 789; // 32 bytes -> stored in slot 3

}

/*

each  slot takes 32 bytes 
---
ordering of the vraibles matter as, it will save on gas fees

if each slot only takes 32 bytes ordering of these vraoibles should be 
done in a way that each slot is "packed"



*/