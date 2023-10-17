// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {Raffle} from "../src/Raffle.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {CreateSubscription, FundSubscription, AddConsumer} from "./Interactions.s.sol";

contract DeployRaffle is Script {
    function run() external returns (Raffle, HelperConfig) {
        // Before startBroadcast -> Not a "real" tx
        HelperConfig helperConfig = new HelperConfig();
        (
            uint64 subscriptionId,
            bytes32 gasLane,
            uint256 interval,
            uint256 entranceFee,
            uint32 callbackGasLimit,
            address vrfCoordinator,
            address linkTokenAddress
        ) = helperConfig.activeNetworkConfig();

        if (subscriptionId == 0) {
            // Create a new subscription
            CreateSubscription cs = new CreateSubscription();
            subscriptionId = cs.createSubscription(vrfCoordinator);

            // Fund it
            FundSubscription fs = new FundSubscription();
            fs.fundSubscription(
                vrfCoordinator,
                subscriptionId,
                linkTokenAddress
            );
        }

        // After startBroadcast -> Real tx !
        vm.startBroadcast();
        Raffle raffle = new Raffle(
            subscriptionId,
            gasLane,
            interval,
            entranceFee,
            callbackGasLimit,
            vrfCoordinator
        );
        vm.stopBroadcast();

        // Add consumer
        AddConsumer ac = new AddConsumer();
        ac.addConsumer(address(raffle), vrfCoordinator, subscriptionId);
        return (raffle, helperConfig);
    }
}
