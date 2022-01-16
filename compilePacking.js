//importing required modules/libraries
const path = require('path');
const fs = require('fs');
const solc = require('solc')

//building path to our contract file
const contrPath = path.resolve(__dirname, 'contracts', 'Packing.sol');

//reading source code from file
const source = fs.readFileSync(contrPath, 'utf8');

//compiling our source code
const input = {
    language: "Solidity",
    sources: {
        "Packing.sol": {
            content: source,
        },
    },
    settings: {
        outputSelection: {
            "*": {
                "*": ["*"],
            },
        },
    },
};

var output=JSON.parse(solc.compile(JSON.stringify(input)));

const interface = output.contracts['Packing.sol'].Packing.abi;
const bytecode = output.contracts['Packing.sol'].Packing.evm.bytecode.object;

// console.log(interface);
module.exports = {
    interface,
    bytecode,
};