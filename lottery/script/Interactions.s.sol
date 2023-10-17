// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {Raffle} from "../src/Raffle.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {VRFCoordinatorV2Mock} from "@chainlink/contracts/src/v0.8/mocks/VRFCoordinatorV2Mock.sol";
import {LinkToken} from "../test/mocks/LinkToken.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract CreateSubscription is Script {
    function createSubscriptionUsingConfig() public returns (uint64) {
        HelperConfig helperConfig = new HelperConfig();
        (, , , , , address vrfCoordinator, ) = helperConfig
            .activeNetworkConfig();
        return createSubscription(vrfCoordinator);
    }

    /**
     *  Create ChainLink subscription programaticaly
     */
    function createSubscription(
        address vrfCoordinator
    ) public returns (uint64) {
        console.log("Creating subscription on chainid: ", block.chainid);

        vm.startBroadcast();
        uint64 subId = VRFCoordinatorV2Mock(vrfCoordinator)
            .createSubscription();
        vm.stopBroadcast();
        console.log("SubId: ", subId);
        return subId;
    }

    function run() external returns (uint64) {
        return createSubscriptionUsingConfig();
    }
}

contract FundSubscription is Script {
    uint96 public constant FUND_AMOUNT = 3 ether;

    function fundSubscriptionUsingConfig() public {
        HelperConfig helperConfig = new HelperConfig();
        (
            uint64 subscriptionId,
            ,
            ,
            ,
            ,
            address vrfCoordinator,
            address linkTokenAddress
        ) = helperConfig.activeNetworkConfig();
        return
            fundSubscription(vrfCoordinator, subscriptionId, linkTokenAddress);
    }

    /**
     *  Create ChainLink subscription programaticaly
     */
    function fundSubscription(
        address vrfCoordinator,
        uint64 subscriptionId,
        address linkTokenAddress
    ) public {
        console.log("Funding subscription: ", subscriptionId);
        console.log("Using vrfCoordinator: ", vrfCoordinator);
        console.log("On chainID: ", block.chainid);

        if (block.chainid == 31337) {
            vm.startBroadcast();
            VRFCoordinatorV2Mock(vrfCoordinator).fundSubscription(
                subscriptionId,
                FUND_AMOUNT
            );
            vm.stopBroadcast();
        } else {
            vm.startBroadcast();
            LinkToken(linkTokenAddress).transferAndCall(
                vrfCoordinator,
                FUND_AMOUNT,
                abi.encode(subscriptionId)
            );
            vm.stopBroadcast();
        }
    }

    function run() external {
        fundSubscriptionUsingConfig();
    }
}

contract AddConsumer is Script {
    uint96 public constant FUND_AMOUNT = 3 ether;

    function addConsumerUsingConfig(address raffle) public {
        HelperConfig helperConfig = new HelperConfig();
        (uint64 subscriptionId, , , , , address vrfCoordinator, ) = helperConfig
            .activeNetworkConfig();
        return addConsumer(raffle, vrfCoordinator, subscriptionId);
    }

    /**
     *  Add Chainlink consumer programaticaly
     */
    function addConsumer(
        address raffle,
        address vrfCoordinator,
        uint64 subscriptionId
    ) public {
        console.log("Adding consumer: ", raffle);
        console.log("Using vrfCoordinator: ", vrfCoordinator);
        console.log("On chainID: ", block.chainid);

        vm.startBroadcast();
        VRFCoordinatorV2Mock(vrfCoordinator).addConsumer(
            subscriptionId,
            raffle
        );
        vm.stopBroadcast();
    }

    function run() external {
        address raffle = DevOpsTools.get_most_recent_deployment(
            "raffle",
            block.chainid
        );
        addConsumerUsingConfig(raffle);
    }
}
