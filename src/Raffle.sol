// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {VRFConsumerBaseV2Plus} from "@chainlink/contracts/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";


/**
 * @title Raffle Contract 
 * @author Shoaib Ali
 * @notice This contract is for creating a sample raffle
 * @dev Implements Chainlink VRFv2.5
 */



contract Raffle is VRFConsumerBaseV2Plus {

    //Errors
    error Raffle__SendMoreToEnterRaffle();

    //State Varibales
    uint256 private immutable i_entranceFee;
    uint256 private immutable i_interval;
    address payable[] private s_players;
    uint256 private s_lastTimeStamp;



    //Events
    event RaffleEntered(address indexed player);


    constructor(uint256 entranceFee, uint256 interval, address vrfCoordinator) VRFConsumerBaseV2Plus(vrfCoordinator)
    {

        i_entranceFee=entranceFee;
        i_interval = interval;
        s_lastTimeStamp = block.timestamp;

    }

    function enterRaffle() external payable {

        //require(msg.value >= i_entranceFee, SendMoreToEnterRaffle());
        if(msg.value<i_entranceFee)
        {
            revert Raffle__SendMoreToEnterRaffle();
        }

        s_players.push(payable(msg.sender));
        emit RaffleEntered(msg.sender);


    }


    function pickWinner() external {
       if( block.timestamp - s_lastTimeStamp > i_interval)
       {
        revert(); 
       }

        requestId = s_vrfCoordinator.requestRandomWords(
        VRFV2PlusClient.RandomWordsRequest({
        keyHash: s_keyHash,
        subId: s_subscriptionId,
        requestConfirmations: requestConfirmations,
        callbackGasLimit: callbackGasLimit,
        numWords: numWords,
        extraArgs: VRFV2PlusClient._argsToBytes(
          // Set nativePayment to true to pay for VRF requests with Sepolia ETH instead of LINK
          VRFV2PlusClient.ExtraArgsV1({nativePayment: false})
        )
      })
    );



    }


    function getEntranceFee() public view returns(uint256)
    {
        return i_entranceFee;
    }

    function fulfillRandomWords(uint256 requestId, uint256[] calldata randomWords) internal virtual override {

    }




}