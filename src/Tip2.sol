// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract Tip2 {
    uint256 public variable1;
    string public constant variable4 = "Hello World";

    // bytes32 public constant variable4 = "Hello World";
    mapping(uint256 => uint256) public variable2;

    constructor() payable {
        variable1 = 5;
    }

    function foo1(uint256 someNum) external {
        variable2[variable1] = someNum;
    }

    function foo2(uint256 someNum) external {
        uint256 tempBar = variable1; // tempBar is in memory and cheaper to read from
        variable2[tempBar] = someNum;
    }
}
