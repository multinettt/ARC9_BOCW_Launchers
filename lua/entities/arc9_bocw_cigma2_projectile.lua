ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Cigma 2 Rocket (BOCW)"
ENT.Author = ""
ENT.Information = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Ticks = 0
ENT.CollisionGroup = COLLISION_GROUP_PROJECTILE
ENT.CanPickup = false

ENT.Damage = 500
ENT.Radius = 256

if CLIENT then
    killicon.Add("arc9_bocw_cigma2_projectile", "entities/obit_arc9_bocw_cigma2.png", Color(255, 255, 255, 255))
end

if SERVER then
    AddCSLuaFile()

    function ENT:Initialize()
        self:SetModel("models/weapons/arc9/entities/bocw_cigma2_projectile.mdl")
        self:SetSolid(SOLID_VPHYSICS)
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:DrawShadow(false)
        local phys = self:GetPhysicsObject()

        if (phys:IsValid()) then
            phys:Wake()
            phys:EnableGravity(true)
            phys:SetBuoyancyRatio(0.1)
            phys:SetDragCoefficient(5)
            phys:SetMass(10) -- avoid collision damage
        end

        util.SpriteTrail(self, 0, Color(255, 255, 255), false, 3, 1, 0.15, 2, "trails/smoke.vmt")
        SafeRemoveEntityDelayed(self, 60)
        self:SetPhysicsAttacker(self:GetOwner(), 10)

        self.SpawnTime = CurTime()
        self.BoostTime = 6
        self.Boost = 5000
    end

    function ENT:Think()
        if self.Defused then return end

        if self:WaterLevel() > 0 then
            self:Detonate()
            return
        end

        if self.BoostTime + self.SpawnTime > CurTime() then
            local vel = self:GetVelocity():Length()
            if not self.BoostTarget or vel < self.BoostTarget then
                self:GetPhysicsObject():AddVelocity(self:GetForward() * self.Boost)
            end
            self:GetPhysicsObject():AddVelocity(Vector(0, 0, self.Lift))
        end

        local v = self:GetVelocity()
        if v:Length() >= 583 then
            self:SetAngles(v:Angle())
            self:GetPhysicsObject():SetVelocityInstantaneous(v)
        end

        self:NextThink(CurTime() + 0.03)

        return true
    end

    function ENT:Detonate() -- taken and adapted from arc9_bo1_projectile_base.lua, credit Palindrone i think
        if not self:IsValid() then return end
        if self.Defused then return end
        local effectdata = EffectData()
        effectdata:SetOrigin( self:GetPos() )

        if self:WaterLevel() > 0 then
            util.Effect("WaterSurfaceExplosion", effectdata)
        else
            util.Effect("Explosion", effectdata)
        end

        util.BlastDamage(self, IsValid(self:GetOwner()) and self:GetOwner() or self, self:GetPos(), self.Radius, self.DamageOverride or self.Damage)

        self.Defused = true

        SafeRemoveEntity(self)
        self:SetRenderMode(RENDERMODE_NONE)
        self:SetMoveType(MOVETYPE_NONE)
        self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
    end

    function ENT:PhysicsCollide(data, physobj)
        if self.Stuck then return end
        self.Stuck = true
        self.OldVelocity = data.OurOldVelocity
        local tgt = data.HitEntity
        local dmginfo = DamageInfo()
        dmginfo:SetDamageType(DMG_BLAST)
        dmginfo:SetDamage(self.Damage)
        dmginfo:SetAttacker(self:GetOwner())
        dmginfo:SetInflictor(self)
        dmginfo:SetDamageForce(self.OldVelocity * 10)
        tgt:TakeDamageInfo(dmginfo)

        self:Detonate()
    end
end

function ENT:Draw()
    self:DrawModel()
end