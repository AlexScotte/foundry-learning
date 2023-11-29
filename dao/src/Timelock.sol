// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {TimelockController} from "@openzeppelin/contracts/governance/TimelockController.sol";

contract Timelock is TimelockController {
    /**
     *
     * @param mintDelay is how long you have to wait before executing
     * @param proposers is the list of addresses that can propose
     * @param executors is the list of addresses that can execute
     */
    constructor(uint256 mintDelay, address[] memory proposers, address[] memory executors)
        TimelockController(mintDelay, proposers, executors, msg.sender)
    {}
}
