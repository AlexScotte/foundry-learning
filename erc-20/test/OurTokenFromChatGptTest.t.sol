// NEED to fix Chat GPT test

// // SPDX-License-Identifier: MIT

// pragma solidity ^0.8.19;

// import {DeployOurToken} from "../script/DeployOurToken.s.sol";
// import {OurToken} from "../src/OurToken.sol";
// import {Test, console} from "forge-std/Test.sol";
// import {StdCheats} from "forge-std/StdCheats.sol";

// interface MintableToken {
//     function mint(address, uint256) external;
// }

// contract OurTokenTest is StdCheats, Test {
//     OurToken public ourToken;
//     DeployOurToken public deployer;
//     address public user2;

//     function setUp() public {
//         deployer = new DeployOurToken();
//         ourToken = deployer.run();
//         user2 = address(new TestAccount());
//     }

//     function testInitialSupply() public {
//         assertEq(ourToken.totalSupply(), deployer.INITIAL_SUPPLY());
//     }

//     function testUsersCantMint() public {
//         vm.expectRevert();
//         MintableToken(address(ourToken)).mint(address(this), 1);
//     }

//     function testAllowance() public {
//         uint256 amountToApprove = 1000;

//         ourToken.approve(user2, amountToApprove);
//         assertEq(ourToken.allowance(address(this), user2), amountToApprove);
//     }

//     function testTransfer() public {
//         uint256 amountToTransfer = 1000;

//         assertEq(ourToken.balanceOf(user2), 0);
//         ourToken.transfer(user2, amountToTransfer);
//         assertEq(ourToken.balanceOf(user2), amountToTransfer);
//     }

//     function testTransferFrom() public {
//         uint256 amountToApprove = 1000;
//         uint256 amountToTransfer = 500;

//         ourToken.approve(user2, amountToApprove);
//         ourToken.transferFrom(address(this), user2, amountToTransfer);
//         assertEq(ourToken.balanceOf(user2), amountToTransfer);
//         assertEq(
//             ourToken.allowance(address(this), user2),
//             amountToApprove - amountToTransfer
//         );
//     }

//     function testFailUnapprovedTransferFrom() public {
//         vm.expectRevert();
//         uint256 amountToTransfer = 500;
//         ourToken.transferFrom(address(this), user2, amountToTransfer);
//     }

//     function testFailOverTransfer() public {
//         vm.expectRevert();
//         uint256 initialBalance = ourToken.balanceOf(address(this));
//         ourToken.transfer(user2, initialBalance + 1);
//     }
// }
