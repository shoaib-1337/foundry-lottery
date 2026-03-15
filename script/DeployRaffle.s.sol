// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19 ;

import {Script} from "forge-std/Script.sol";
import {Raffle} from "../src/Raffle.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployRaffle is Script {
    function run() public {
        // deploy logic
    }

    function deployContract() public returns (Raffle, HelperConfig) {
        HelperConfig helperConfig = new HelperConfig();
        Raffle raffle = new Raffle(
            helperConfig.getConfigByChainId(31337).entranceFee,
            helperConfig.getConfigByChainId(31337).interval,
            helperConfig.getConfigByChainId(31337).vrfCoordinator,
            helperConfig.getConfigByChainId(31337).gasLane,
            helperConfig.getConfigByChainId(31337).subscriptionId,
            uint32(helperConfig.getConfigByChainId(31337).callbackGasLimit)
        );
        return (raffle, helperConfig);
    }
}
