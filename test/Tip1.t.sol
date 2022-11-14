// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/Tip1.sol";

import "forge-std/Test.sol";

contract Tip1Test is Test {
    Tip1 public tip1;

    function setUp() public {
        tip1 = new Tip1();
    }

    function testTip1() public {
        tip1.setTime(4);
    }
}
