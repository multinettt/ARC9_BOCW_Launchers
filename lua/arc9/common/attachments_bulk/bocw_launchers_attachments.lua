--=============================================================================
--   ARC9 CALL OF DUTY: BLACK OPS COLD WAR
--   LAUNCHERS
--   ATTACHMENTS BULK
local ATT = {}
--========== Cigma 2 ==========================================================
ATT = {}

ATT.PrintName = "OPTIC"
ATT.CompactName = "OPTIC"
ATT.Icon = Material("hud/arc9_bocw/scopes/reticle_cigma2.png", "mips smooth")
ATT.Description = ""

ATT.SortOrder = -10

ATT.Model = "models/weapons/arc9/atts/bocw_scope_cigma2.mdl"

ATT.ModelOffset = Vector(0, 0, 0)
ATT.ModelAngleOffset = Angle(0, 0, 0)

ATT.Category = {"bocw_cigma2_optic"}

ATT.Sights = {
    {
        Pos = Vector(2.70726, 13.35, -0.1),
        Ang = Angle(0, 0, 0),
        Magnification = 2,
        ViewModelFOV = 35,
        Blur = true
    },
}

ATT.RTScopeAdjustable = false

ATT.RTScope = true
ATT.RTScopeSubmatIndex = 2
ATT.RTScopeMagnification = 1
ATT.RTScopeReticle = Material("hud/arc9_bocw/scopes/reticle_cigma2.png", "mips smooth")

ATT.RTScopeReticleScale = 0.85
ATT.RTScopeNew_ShadowScale = 1.4
ATT.RTScopeNew_ReticleBlackBox = false
ATT.RTScopeNew_ShaderDistorsionMult = 0.1

ATT.RTScopeNew_DisableRTVM = true
ATT.RTScopeNew_DisableShader = true
ATT.RTScopeNew_DisableShaderEyeOffset = false

ATT.RTScopeColorable = true

ATT.MenuCategory = "ARC9 - BOCW Attachments"

ARC9.LoadAttachment(ATT, "bocw_optic_cigma2")