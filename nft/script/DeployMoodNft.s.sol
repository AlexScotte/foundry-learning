// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {Script, console2} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    function setUp() public {}

    function run() external returns (MoodNft) {
        string memory sadSvg = vm.readFile("./img/dynamicNft/sad.svg");
        string memory happySvg = vm.readFile("./img/dynamicNft/happy.svg");

        vm.startBroadcast();
        MoodNft mn = new MoodNft(
            svgToImageUri(sadSvg),
            svgToImageUri(happySvg)
        );
        vm.stopBroadcast();
        return mn;
    }

    function svgToImageUri(
        string memory svg
    ) public pure returns (string memory) {
        // example:
        // arg: <svg viewBox="0 0 200 200" width="400" ...
        // return: "data:application/json;base64,eyJuYW1l ...
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}
