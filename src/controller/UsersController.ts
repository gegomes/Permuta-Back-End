import { Request, Response } from "express";
import { check, validationResult } from 'express-validator'
import { UsersDatabase } from "../database/users.database";

class UsersController {

    static async signUp(request: Request, response: Response) {
        const { email, password } = request.body;
        const errors = validationResult(request);
        if (!errors.isEmpty()) {
            return response.status(200).json(errors)
        } else {
            try {
                const content = await UsersDatabase.register(email, password);
                return response.status(200).json(content)
            } catch (error) {
                return response.status(401).json(error)
            }
        }
    }

    static async signIn(request: Request, response: Response) {
        const { email, password } = request.body;
        const errors = validationResult(request);
        if (!errors.isEmpty()) {
            return response.status(200).json(errors)
        } else {
            try {
                const content = await UsersDatabase.signIn(email, password);
                return response.status(200).json(content)
            } catch (error) {
                return response.status(401).json(error)
            }
        }
    }

}


export { UsersController }