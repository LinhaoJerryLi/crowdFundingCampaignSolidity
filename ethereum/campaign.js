const address = "0x3D7d6f73901a72be13f26BaA4a517000CC593E88";
const abi = [
  {
    inputs: [{ internalType: "uint256", name: "minimum", type: "uint256" }],
    name: "createCampaign",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
    constant: undefined,
    payable: undefined,
    signature: "0xa3303a75",
  },
  {
    inputs: [{ internalType: "uint256", name: "", type: "uint256" }],
    name: "deployedCampaigns",
    outputs: [{ internalType: "address", name: "", type: "address" }],
    stateMutability: "view",
    type: "function",
    constant: true,
    payable: undefined,
    signature: "0x339d50a5",
  },
  {
    inputs: [],
    name: "getDeployedCampaigns",
    outputs: [{ internalType: "address[]", name: "", type: "address[]" }],
    stateMutability: "view",
    type: "function",
    constant: true,
    payable: undefined,
    signature: "0x4acb9d4f",
  },
];
