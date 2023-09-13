import { Request, Response } from "express"
export class MeController {
  static async verifyToken(request: Request, response: Response) {    
    return response.json({ data: request.user})
  }
}