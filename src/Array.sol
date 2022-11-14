// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Array {
    uint256[10] public number;
    uint256[5] public number2;
    uint256 public num = 10;

    ///@notice Looping over a storage array: Without cache
    function loop() public view {
        for (uint256 i; i < number.length;) {
            ++i;
        }
    }

    ///@notice Looping over a storage array with cached length outside of the loop
    function loop1() public pure {
        uint256 length = 10;
        for (uint256 i; i < length;) {
            ++i;
        }
    }

    ///@notice Looping over a storage array
    function loop2() public pure {
        uint256[] memory num1 = new uint256[](10);
        for (uint256 i; i < num1.length;) {
            ++i;
        }
    }

    ///@notice Looping over a storage array
    function loop3() public view {
        for (uint256 i; i > number2.length;) {
            i++;
        }
    }
}
