// // SPDX-License-Identifier: UNLICENSED
// // Have our invariant aka properties

// // What are our invariants ?

// // 1. The total supply of DSC should be less than the total value of collateral

// // 2. Getter view functions should never revert <- evergreen invariant

// pragma solidity ^0.8.19;

// import {Test, console2} from "forge-std/Test.sol";
// import {StdInvariant} from "forge-std/StdInvariant.sol";
// import {DSCEngine} from "../../src/DSCEngine.s.sol";
// import {DeployDSC} from "../../script/DeployDSC.s.sol";
// import {DecentralizedStableCoin} from "../../src/DecentralizedStableCoin.s.sol";
// import {HelperConfig} from "../../script/HelperConfig.s.sol";
// import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// // import {ERC20Mock} from "@openzeppelin/contracts/mocks/ERC20Mock.sol";
// // import {MockV3Aggregator} from "../mocks/MockV3Aggregator.sol";
// // import {MockMoreDebtDSC} from "../mocks/MockMoreDebtDSC.sol";
// // import {MockFailedMintDSC} from "../mocks/MockFailedMintDSC.sol";
// // import {MockFailedTransferFrom} from "../mocks/MockFailedTransferFrom.sol";
// // import {MockFailedTransfer} from "../mocks/MockFailedTransfer.sol";

// contract OpenInvariantsTest is StdInvariant, Test {
//     DeployDSC deployer;
//     DSCEngine dscEngine;
//     DecentralizedStableCoin dsc;
//     HelperConfig config;
//     address weth;
//     address btc;

//     function setUp() external {
//         deployer = new DeployDSC();
//         (dsc, dscEngine, config) = deployer.run();
//         (,, weth, btc,) = config.activeNetworkConfig();
//         targetContract(address(dscEngine));
//     }

//     function invariant_protocolMustHaveMoreValueThanTotalSupply() public view {
//         // get the value of all the collateral in the protocol
//         // compare it to all the debt (DSC)

//         uint256 totalSupply = dsc.totalSupply();
//         uint256 totalWethDeposited = IERC20(weth).balanceOf(address(dscEngine));
//         uint256 totalBtcDeposited = IERC20(btc).balanceOf(address(dscEngine));

//         uint256 wethValue = dscEngine.getUsdValue(weth, totalWethDeposited);
//         uint256 btcValue = dscEngine.getUsdValue(btc, totalBtcDeposited);

//         assert(wethValue + btcValue >= totalSupply);
//     }
// }
