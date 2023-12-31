// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {Script, console2} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract DeployBasicNft is Script {
    function setUp() public {}

    function run() external returns (BasicNft) {
        vm.startBroadcast();
        BasicNft bn = new BasicNft();
        vm.stopBroadcast();

        return bn;
    }
}
