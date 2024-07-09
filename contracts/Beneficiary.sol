// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/finance/VestingWallet.sol";

/// @custom:security-contact security@medinaestate.io
contract Beneficiary is VestingWallet {
    uint256 public amount;

    constructor(
        address beneficiaryAddress,
        uint64 startTimestamp,
        uint64 durationSeconds,
        uint256 _amount
    ) VestingWallet(beneficiaryAddress, startTimestamp, durationSeconds) {
        amount = _amount;
    }
}
