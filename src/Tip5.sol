// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Array {
    uint256[10] public number;

    ///@notice Looping over a storage array: Without cache
    function loop1() public view {
        for (uint256 i; i < number.length;) {
            ++i;
        }
    }

    ///@notice Looping over a storage array with cached length outside of the loop
    function loop2() public view {
        uint256 length = number.length;
        for (uint256 i; i < length;) {
            ++i;
        }
    }

    ///@notice Looping over a memory array without cached length
    function loop3() public pure {
        uint256[] memory num1 = new uint256[](10);
        for (uint256 i; i < num1.length;) {
            ++i;
        }
    }

    ///@notice Looping over a storage array with cached length outside of the loop
    function loop4() public pure {
        uint256[] memory num1 = new uint256[](10);
        uint256 length = num1.length;
        for (uint256 i; i < length;) {
            ++i;
        }
    }
}
