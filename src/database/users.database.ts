import "dotenv/config"
import { genSaltSync, hashSync, compareSync } from "bcrypt"
import { sign } from 'jsonwebtoken';
import { poll } from "./mysql";

class UsersDatabase {

    static async register(email: string, password: string) {
        try {
            const salt = genSaltSync(10);
            const passwordHash = hashSync(password, salt);

            // VERIFICAR SE EXISTE USUÁRIO COM ESSE E-MAIL
            const [users_email] = await poll.query("SELECT email FROM users WHERE users.email = ? LIMIT 1;", [email]);
            const email_if_exist = users_email[0]?.email
            if (email_if_exist) return { path: "LOG::USERS.DATABASE.TS::REGISTER::EMAIL_IF_EXIST", error: true, message: "ESSE E-MAIL JÁ FOI CADASTRADO NA BASE DE DADOS, FAVOR ENTRAR EM CONTATO COM O ADMINISTRADOR DO SISTEMA.", rows: {} }

            const [rows] = await poll.query("INSERT INTO users (email,password) VALUES (?,?);", [email, passwordHash]);
            return { path: "LOG::USERS.DATABASE.TS::REGISTER::ROWS", error: false, message: 'USUÁRIO CADASTRADO COM SUCESSO.', rows };

        } catch (error) {
            return { path: "LOG::USERS.DATABASE.TS::REGISTER::CATCH", error: true, message: error, rows: {} };
        }
    }


    static async signIn(email: string, password: string) {
        try {
            const [user_db] = await poll.query("SELECT * FROM users WHERE users.email = ? AND users.is_active = 'ACTIVE' LIMIT 1;", [email]);

            const user = user_db[0]
            const user_exist_exist = user?.email;
            if (!user_exist_exist) return { path: "LOG::USERS.DATABASE.TS::REGISTER::EMAIL_IF_EXIST", error: true, message: "E-MAIL E/OU SENHA INCORRETOS E/OU USUARIO ESTÁ INATIVO.", rows: {} }

            const passwordMatched = compareSync(password, user?.password);
            if (!passwordMatched) return { path: "LOG::USERS.DATABASE.TS::REGISTER::EMAIL_IF_EXIST", error: true, message: "E-MAIL E/OU SENHA INCORRETOS.", rows: {} }

            delete user.password;
            console.log(process.env.JWT_KEY);
            
            const token = sign({ user: JSON.stringify(user) }, String(process.env.JWT_KEY), { expiresIn: '1d' })
            return { path: "LOG::USERS.DATABASE.TS::SIGNIN::TOKEN", error: false, message: {}, rows: { token, user } };
        } catch (error) {
            return { path: "LOG::USERS.DATABASE.TS::SIGNIN::CATCH", error: true, message: error, rows: {} };
        }


    }

}

export { UsersDatabase }