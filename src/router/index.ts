import { check } from 'express-validator'
import { Router } from "express"
import { UsersController } from "../controller/UsersController"
import { MeController } from '../controller/MeController'
import { ensureAuthentication } from '../middleware/ensureAuthentication'
import { ensurePermission } from '../middleware/ensurePermission'
import { CustumersController } from '../controller/CustumersController'

const router = Router()

router.post("/v1/users/register", [
    check("email").notEmpty().withMessage("Preencha o campo de e-mail"),
    check("password").notEmpty().withMessage("Preencha o campo de senha")
], UsersController.signUp)

router.post("/v1/users/session", [
    check("email").notEmpty().withMessage("Preencha o campo de e-mail"),
    check("password").notEmpty().withMessage("Preencha o campo de senha")
], UsersController.signIn)


router.post("/v1/verify-token",
    ensureAuthentication,
    ensurePermission(['administrador', 'verificar-token']),
    MeController.verifyToken
)

router.post("/v1/custumers/create", ensureAuthentication, CustumersController.create)
router.post("/v1/custumers/find", ensureAuthentication, CustumersController.find)
router.patch("/v1/custumers/update", ensureAuthentication, ensurePermission(['administrador', 'atualizar-custumers']), CustumersController.update)

export { router }