// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract Tip2 {
    uint256 public variable1 = 5;
    mapping(uint256 => uint256) public variable2;

    function foo1(uint256 someNum) external {
        variable2[variable1] = someNum;
    }

    function foo2(uint256 someNum) external {
        uint256 tempBar = variable1; // tempBar is in memory and cheaper to read from
        variable2[variable1] = someNum;
    }
}
