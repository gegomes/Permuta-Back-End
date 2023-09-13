import console from "console";
import { poll } from "./mysql";

interface ICustumer {
  id?: number;
  user_id?: number
  name: string
  phone: string
  email: string
  created_at?: string
  updated_at?: string
}

interface ICustumerUpdate {
  id: number;
  user_id?: number
  name?: string
  phone?: string
  email?: string
  created_at?: string
  updated_at?: string
}

export class CustumerDatabase {
  static async create(data: ICustumer): Promise<any | unknown | Error> {

    const [exists] = await poll.query("SELECT * FROM customers WHERE email =?", [data.email]);

    if (exists[0]) {
      return { status: 401, erro: true, data: exists[0], message: "Email already exists" };
    } else {
      const [custumer] = await poll.query("insert into customers (user_id, name, phone, email) values(?,?,?,?)", [
        data.user_id,
        data.name,
        data.phone,
        data.email
      ]) as any
      return { status: 201, erro: false, data: custumer?.affectedRows, message: "ok!" };
    }
  }

  static async find(email: string) {
    const [custumer] = await poll.query("SELECT * FROM customers WHERE email =?", [email]);
    if (custumer[0]) {
      return { status: 200, erro: false, data: custumer[0], message: "ok!" };
    }
    return { status: 400, erro: true, data: [], message: "não foi encontrado nenhum resultado" };
  }

  static async update(data: ICustumerUpdate): Promise<any | unknown | Error> {
    try {
      const [custumer] = await poll.query("UPDATE customers SET name=?,phone=?,email=? WHERE id=?", [
        data.name,
        data.phone,
        data.email,
        data.id
      ]) as any;

      if (custumer?.affectedRows) {
        const [returns] = await poll.query("SELECT * FROM customers WHERE id=?", data.id)
        return { status: 200, erro: false, data: returns[0], message: "ok!" };
      } else {
        return { status: 400, erro: true, data: [], message: "erro ao tentar atualizar." };
      }

    } catch (error) {
      return { status: 400, erro: true, data: [], message: "erro ao tentar atualizar." };
    }
  }

  static async delete() { }

  static async findById() { }

  static async findByName() { }
}