import { Request, Response } from "express"
import { CustumerDatabase } from "../database/custumer.database"
import console from "console";
export class CustumersController {
  static async create(request: Request, response: Response) {
    const { name, email, phone } = request.body
    try {
      const user_id = request.user.id;
      const returns = await CustumerDatabase.create({ user_id, name, email, phone })
      return response.status(returns.status).json({ data: returns })
    } catch (error) {
      return response.status(400).json(error)
    }
  }

  static async find(request: Request, response: Response) {
    const { email } = request.body
    try {
      const returns = await CustumerDatabase.find(email)
      return response.status(returns.status).json({ data: returns })
    } catch (error) {
      return response.status(400).json(error)
    }
  }

  static async update(request: Request, response: Response) {
    const { name, phone, email, id } = request.body
    try {
      const returns = await CustumerDatabase.update({ name, phone, email, id })       
      return response.status(returns.status).json({ data: returns })
    } catch (error) {
      return response.status(400).json(error)
    }
  }
}