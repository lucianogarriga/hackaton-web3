import React, { useEffect, useState } from "react";
import { Header } from "../componentes/Header";

import "./PaginaHome.css";
import { SeccionUsuario } from "../componentes/SeccionUsuario";
import ConnectUser from "../componentes/ConnectUser";

// import { useContractReads } from 'wagmi'
// import { useContract } from 'wagmi'

const PaginaHome = () => {
  const [estaConectado, setEstaConectado] = useState(false);

  return (
    <section className="bodyBorder">
      <Header />
      <ConnectUser
        setEstaConectado={setEstaConectado}
        estaConectado={estaConectado}
      />
      {estaConectado && <SeccionUsuario />}
      {/* <div>{balance !== undefined ?? <p>BALANCE: {balance}</p>}</div> */}
    </section>
  );
};

export { PaginaHome };
