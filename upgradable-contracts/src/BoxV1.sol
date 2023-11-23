// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract BoxV1 is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    uint256 internal number;

    /**
     * @custom:oz-upgrades-unsafe-allow constructor
     * Can't use contructor with proxy pattern
     * Constructor add storage to the implementation
     */
    constructor() {
        _disableInitializers();
    }

    function intialize() public {
        __Ownable_init(msg.sender); // sets owner to: owner = msg.sender
        __UUPSUpgradeable_init();
    }

    function getNumber() external view returns (uint256) {
        return number;
    }

    function version() external pure returns (uint256) {
        return 1;
    }

    function _authorizeUpgrade(address newImplementation) internal override {}
}
