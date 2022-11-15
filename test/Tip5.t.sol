// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/Tip5.sol";
import "forge-std/Test.sol";

contract Tip5 is Test {
    Array public array;

    function setUp() public {
        array = new Array();
    }

    function testLoop1() public view {
        array.loop1();
    }

    function testLoop2() public view {
        array.loop2();
    }

    function testLoop3() public view {
        array.loop3();
    }

    function testLoop4() public view {
        array.loop4();
    }
}
