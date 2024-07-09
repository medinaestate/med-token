// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @custom:security-contact security@medinaestate.io
contract MedinaToken is ERC20, Ownable {
    address private _beneficiariesFactory;
    uint256 public burnPercentage;

    constructor() ERC20("MedinaToken", "MED") Ownable(msg.sender) {
        _mint(msg.sender, 100000000 * 10 ** decimals());
        burnPercentage = 0;
    }

    modifier onlyBeneficiariesFactory() {
        msg.sender == _beneficiariesFactory;
        _;
    }

    function setBeneficiariesFactory(
        address beneficiariesFactory
    ) external onlyOwner {
        _beneficiariesFactory = beneficiariesFactory;
    }

    function setBurnPercentage(uint256 _burnPercentage) external onlyOwner {
        require(_burnPercentage != 0, "Must define a percentage.");
        require(_burnPercentage <= 2, "Percentage too big.");
        require(burnPercentage == 0, "Percentage already setted.");

        burnPercentage = _burnPercentage;
    }

    function transfer(
        address to,
        uint256 value
    ) public override returns (bool) {
        uint256 burnAmount = calculateBurnPercentage(value);
        uint256 sendAmount = value - burnAmount;

        _burn(_msgSender(), burnAmount);
        return super.transfer(to, sendAmount);
    }

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) public override returns (bool) {
        uint256 burnAmount = calculateBurnPercentage(value);
        uint256 sendAmount = value - burnAmount;

        _burn(from, burnAmount);
        return super.transferFrom(from, to, sendAmount);
    }

    function transferUnburned(
        address to,
        uint256 value
    ) public onlyBeneficiariesFactory returns (bool) {
        return super.transfer(to, value);
    }

    function calculateBurnPercentage(
        uint256 value
    ) public view returns (uint256) {
        return (value * burnPercentage) / 100;
    }
}
