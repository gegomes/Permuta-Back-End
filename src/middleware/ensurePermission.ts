import { Request, Response, NextFunction } from "express"
import { poll } from "../database/mysql"


export const ensurePermission = (args?: string[]) => {
  return async (request: Request, response: Response, next: NextFunction) => {
    const [userDatabase] = await poll.query("CALL PROCEDURE_CHECK_PERMISSION_USER_LOGADO(?)", [request.user.id])    
    const permissionExists = Object(userDatabase[0]).map(item => item.slug).some(permission => args?.includes(permission))     
    
    if (!permissionExists) {      
      return response.status(403).json({
        status: 403,
        error: "você não tem permissão para usar esse recurso.",
      })
    }
    return next()
  }
} 