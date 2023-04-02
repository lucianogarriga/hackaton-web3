import { useEffect, useState } from "react";
import { useAccount } from "wagmi";
import "./SeccionUsuario.css";
const users = require("../users/users.json");

const UserInexistente = () => {
  return (
    <section className="seccion-usuario">
      <span>Usuario Inexistente</span>
    </section>
  );
};

const UserInquilino = ({ user }) => {
  const pagarExpensa = () => {
    console.log("pagar expensa");
  };

  return (
    <section className="seccion-usuario">
      <span className="user">Welcome {user._name}</span>
      <span className="user">Monto: {user._amount}</span>
      <button onClick={pagarExpensa}>Pay Expenses</button>
    </section>
  );
};

const UserAdmin = ({ user }) => {
  const cobrarSueldo = () => {
    console.log("Cobrar Sueldo");
  };

  return (
    <section className="seccion-usuario">
      <span className="user">Welcome Admin {user._name}</span>
      <span className="user">Balance: {user._amount}</span>
      <button onClick={cobrarSueldo}>Add Tenant</button>
      <button onClick={cobrarSueldo}>Add Employeed</button>
      <button onClick={cobrarSueldo}>Pay Salary</button>
    </section>
  );
};

const SeccionUsuario = () => {
  const { address, isConnecting, isDisconnected } = useAccount();

  let user = users.find((user) => {
    return user._userAddress === address;
  });

  return (
    <section>
      {!user && <UserInexistente />}
      {user && user._role === "inquilino" && <UserInquilino user={user} />}
      {user && user._role === "admin" && <UserAdmin user={user} />}
    </section>
  );
};

export { SeccionUsuario };
