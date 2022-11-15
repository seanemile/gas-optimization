// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/Tip2.sol";

import "forge-std/Test.sol";

contract Tip2Test is Test {
    Tip2 public tip2;

    function setUp() public {
        tip2 = new Tip2();
    }

    function testTip2Foo1() public {
        tip2.foo1(2);
    }

    function testTip2Foo2() public {
        tip2.foo2(2);
    }
}
