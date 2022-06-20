pragma solidity =0.7.6;
pragma abicoder v2;
import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";
import "@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol";

// import "@uniswap/swap-router-contracts/contracts/interfaces/IV3SwapRouter.sol";

contract Swapper {
    ISwapRouter public immutable swapRouter;
    address public DAI = 0xc7AD46e0b8a400Bb3C915120d284AafbA8fc4735;
    address public WETH9 = 0xc778417E063141139Fce010982780140Aa0cD5Ab;
    address public USDC = 0xeb8f08a975Ab53E34D8a0330E0D34de942C95926;

    uint24 public constant poolFee = 3000;

    constructor(ISwapRouter _swapRouter) {
        swapRouter = _swapRouter;
    }

    function setDAIAddr(address _tokenAdr) public {
        DAI = _tokenAdr;
    }

    function setWETHAddr(address _tokenAdr) public {
        WETH9 = _tokenAdr;
    }

    function safeTransferAndApprove(uint256 amountIn) public {
        TransferHelper.safeTransferFrom(
            DAI,
            msg.sender,
            address(this),
            amountIn
        );
        TransferHelper.safeApprove(DAI, address(swapRouter), amountIn);
    }

    function swapExactInputSingle(uint256 amountIn)
        external
        returns (uint256 amountOut)
    {
        safeTransferAndApprove(amountIn);
        ISwapRouter.ExactInputSingleParams memory params = ISwapRouter
            .ExactInputSingleParams({
                tokenIn: DAI,
                tokenOut: WETH9,
                fee: 3000,
                recipient: msg.sender,
                deadline: block.timestamp + 1000,
                amountIn: amountIn,
                amountOutMinimum: 0,
                sqrtPriceLimitX96: 0
            });
        amountOut = swapRouter.exactInputSingle(params);
    }
}
