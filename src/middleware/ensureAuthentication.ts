
import { Request, Response, NextFunction } from "express"
import { verify } from "jsonwebtoken"
export const ensureAuthentication = async (request: Request, response: Response, next: NextFunction) => {




    try {
        const authHeader = request.headers?.authorization;
        if (!authHeader) response.json(401).json({ error: true, message: "JWT inválido." })

        // @ts-ignore
        const [, token] = authHeader?.split(" ");
        if (!token) response.json(401).json({ error: true, message: "JWT inválido." })
        const data = verify(token, String(process.env.JWT_KEY)) as any

        if (data.user) {
            request.user = JSON.parse(data.user)
            return next()
        } else {
            return response.json(401).json({ error: true, message: "JWT inválido." })
        }


    } catch (error) {
        return response.status(400).json({ error })
    }

}