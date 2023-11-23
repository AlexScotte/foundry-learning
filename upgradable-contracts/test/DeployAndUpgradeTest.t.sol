// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {DeployBox} from "../script/DeployBox.s.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";

contract DeployAndUpgradeTest is Test {
    DeployBox public deployer;
    UpgradeBox public upgrader;
    address public OWNER = makeAddr("owner");

    address public proxy;

    function setUp() public {
        deployer = new DeployBox();
        upgrader = new UpgradeBox();
        proxy = deployer.run(); // points to BoxV1 for now
    }

    function testSetupOK() public {
        uint256 expectedValue = 1;
        assertEq(expectedValue, BoxV1(proxy).version());
    }

    function testRevertSetNumberOnProxyBoxV1() public {
        vm.expectRevert();
        // proxy address points to BoxV1 and set number do not exists in this implementation
        BoxV2(proxy).setNumber(7);
    }

    function testUpgradesAndCheckVersion() public {
        BoxV2 box2 = new BoxV2();
        proxy = upgrader.upgradeBox(proxy, address(box2));

        uint256 expectedValue = 2;
        assertEq(expectedValue, BoxV2(proxy).version());
    }

    function testUpgradesAndSetNumber() public {
        BoxV2 box2 = new BoxV2();
        proxy = upgrader.upgradeBox(proxy, address(box2));

        BoxV2(proxy).setNumber(6);
        assertEq(6, BoxV2(proxy).getNumber());
    }
}
