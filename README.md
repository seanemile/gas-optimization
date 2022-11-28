<div>
  <h2>Installation</h2>
  <p> This is a companion repo for the articles gas <a href="https://seanemile.com/home"> optimization in solidity</a></p> 
  <h3>SetUp:</h3>
  <p>
    You will need a copy of
    <a href="https://github.com/foundry-rs/foundry">Foundry</a> installed before
    proceeding. See the
    <a href="https://github.com/foundry-rs/foundry#installation"
      >Installation guide</a
    >
  </p>
  <pre>
   <code>
    git clone https://github.com/seanemile/gas-optimization
    cd gas-optimization
    forge install
   </code>
  </pre>
  <h3>Run Tests</h3>
  <pre>
    All the tests
    <code>
      forge test
    </code>
    Match a specific test
    <code>
      forge test --match-contract ContractName.sol>
    </code>
  </pre>
  <h3>Update Gas Snapshots</h3>
  <pre>
    <code>
      forge snapshot
    </code>
  </pre>
</div>
