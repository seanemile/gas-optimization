// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
/**
 * @title Gas optimization using smaller types
 * @author @SeanEmile
 * @notice Contract is provide as is without any warranty.
 * @custom:security seanemile.se@gmail.com
 */

/**
 * @dev Wrappers over Solidity's uintXX/intXX casting operators with added overflow
 * checks.
 *
 * Downcasing from uint256/int256 in Solidity does not revert on overflow. This can
 * easily result in undesired exploitation or bugs, since developers usually
 * assume that overflows raise errors. `SafeCast` restores this intuition by
 * reverting the transaction when such an operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 *
 * Can be combined with {SafeMath} and {SignedSafeMath} to extend it to smaller types, by performing
 * all math on `uint256` and `int256` and then downcasing.
 */

import {SafeCast} from "openzeppelin-contracts/utils/math/SafeCast.sol";

contract Tip1 {
    using SafeCast for uint256;
    /**
     * @dev Leaves 28 bytes(uint 224) of space after the slot.
     * @custom:variable Timestamp is equal to ( 2^32 - 1 ) which is approximately 100 years from now. should be enough for your needs
     */

    uint32 public timestamp;

    function setTime(uint256 value) public {
        timestamp = value.toUint32();
    }
}
