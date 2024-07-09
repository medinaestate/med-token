// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "./MedinaToken.sol";
import "./Beneficiary.sol";

/// @custom:security-contact security@medinaestate.io
contract Beneficiaries is Ownable, Initializable {
    MedinaToken private _token;

    mapping(address => Beneficiary) private _beneficiaries;

    constructor(MedinaToken token) Ownable(msg.sender) {
        _token = token;
    }

    function initialize(
        address sales,
        address marketing,
        address incentives,
        address team,
        address liquidity,
        address treasury
    ) external initializer onlyOwner {
        uint64 JUL_1ST_2024 = 1719802800;
        uint64 JUL_1ST_2026 = 1782874800;
        uint64 TWO_YEARS = JUL_1ST_2026 - JUL_1ST_2024;

        _createBeneficiary(sales, JUL_1ST_2024, 0, _getAmount(37));
        _createBeneficiary(incentives, JUL_1ST_2024, 0, _getAmount(12));
        _createBeneficiary(team, JUL_1ST_2024, 0, _getAmount(18));
        _createBeneficiary(liquidity, JUL_1ST_2024, 0, _getAmount(12));
        _createBeneficiary(marketing, JUL_1ST_2024, TWO_YEARS, _getAmount(13));
        _createBeneficiary(treasury, JUL_1ST_2026, 0, _getAmount(8));
    }

    function amount(address beneficiary) external view returns (uint256) {
        return _beneficiaries[beneficiary].amount();
    }

    function start(address beneficiary) external view returns (uint256) {
        return _beneficiaries[beneficiary].start();
    }

    function duration(address beneficiary) external view returns (uint256) {
        return _beneficiaries[beneficiary].duration();
    }

    function end(address beneficiary) external view returns (uint256) {
        return
            _beneficiaries[beneficiary].start() +
            _beneficiaries[beneficiary].duration();
    }

    function released(address beneficiary) external view returns (uint256) {
        return _beneficiaries[beneficiary].released(address(_token));
    }

    function releasable(address beneficiary) external view returns (uint256) {
        return _beneficiaries[beneficiary].releasable(address(_token));
    }

    function release(address beneficiary) external {
        return _beneficiaries[beneficiary].release(address(_token));
    }

    function vestedAmount(
        address beneficiary,
        uint64 timestamp
    ) external view returns (uint256) {
        return
            _beneficiaries[beneficiary].vestedAmount(
                address(_token),
                timestamp
            );
    }

    function _getAmount(uint256 percentage) private view returns (uint256) {
        return (_token.totalSupply() * percentage) / 100;
    }

    function _createBeneficiary(
        address beneficiary,
        uint64 startTimestamp,
        uint64 durationSeconds,
        uint256 _amount
    ) private {
        _beneficiaries[beneficiary] = new Beneficiary(
            beneficiary,
            startTimestamp,
            durationSeconds,
            _amount
        );

        require(
            _token.transferUnburned(
                address(_beneficiaries[beneficiary]),
                _amount
            )
        );
    }
}
