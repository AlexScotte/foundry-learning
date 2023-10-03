// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";
import {FundFundMe, WidthdrawFundMe} from "../../script/Interactions.s.sol";

contract InteractionsTest is Test {
    FundMe fundMe;
    HelperConfig helperConfig;
    address USER = makeAddr("user");

    function setUp() external {
        DeployFundMe deployer = new DeployFundMe();
        (fundMe) = deployer.run();

        // Give money to the user
        vm.deal(USER, 10 ether);
    }

    function testUserCanFundInteractions() public {
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(address(fundMe));

        WidthdrawFundMe widthdrawFundMe = new WidthdrawFundMe();
        widthdrawFundMe.widthdrawFundMe(address(fundMe));

        assert(address(fundMe).balance == 0);
    }
}
