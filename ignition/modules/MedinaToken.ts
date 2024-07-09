import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const MedinaTokenModule = buildModule("MedinaTokenModule", (m) => {
  const sales = m.getParameter("sales", m.getAccount(1));
  const team = m.getParameter("team", m.getAccount(2));
  const incentives = m.getParameter("incentives", m.getAccount(3));
  const liquidity = m.getParameter("liquidity", m.getAccount(4));
  const marketing = m.getParameter("marketing", m.getAccount(5));
  const treasury = m.getParameter("treasury", m.getAccount(6));

  // Deploy both contracts
  const MedinaToken = m.contract("MedinaToken");
  const Beneficiaries = m.contract("Beneficiaries", [MedinaToken]);

  // Set relation between contracts
  m.call(MedinaToken, "setBeneficiariesFactory", [Beneficiaries]);

  // Approve to transfer the total supply
  m.call(MedinaToken, "transfer", [
    Beneficiaries,
    100_000_000_000_000_000_000_000_000n,
  ]);

  // Set beneficiaries
  m.call(Beneficiaries, "initialize", [
    sales,
    marketing,
    incentives,
    team,
    liquidity,
    treasury,
  ]);

  return { MedinaToken, Beneficiaries };
});

export default MedinaTokenModule;
