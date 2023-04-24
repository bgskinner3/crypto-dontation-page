// SPDX-License-Identifier: MIT
// pragma solidity >=0.4.22 <0.9.0;

// contract Test {
//     function test(uint256 testNumber) external pure returns (uint data) {
//         assembly {
//            mstore(0x40,0xd2)
//             // let _num := 4
//             // let _fmpm := mload(0x40)

//         }

//         uint8[3] memory items = [1, 2, 3];

//         assembly {
//          // data := mload(0x90) // in the parameters you can choose the position of the memory to return
//           data := mload(add(0x90, 0x20))
//         }

//         // return testNumber;
//     }

//     function test2() external pure returns (bytes32 data) {
//       assembly {
//         let fmp := mload(0x40)
//         mstore(add(fmp, 0x00), 0x68656C6C6F)
//         data := mload(add(fmp, 0x00))
//       }
//     }
// }
