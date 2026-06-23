-- Credit Palindrone for the lock-on code read the thing in shared lua for more info

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

ENT.Damage = 1000
ENT.Radius = 256

ENT.LifeTime = 60
ENT.SteerSpeed = 60
ENT.SeekerAngle = math.cos(35)
ENT.FireAndForget = true
ENT.Drunkenness = 2
ENT.SuperSeeker = false --probly not right this shit is old as hell
ENT.TopAttack = false
ENT.NoReacquire = false --this could make funny clips so keeping it false

ENT.GunshipWorkaround = true
ENT.HelicopterWorkaround = true

ENT.ShootEntData = {}

if CLIENT then
    killicon.Add("arc9_bocw_cigma2_projectile", "entities/obit_arc9_bocw_cigma2.png", Color(255, 255, 255, 255))
end

if SERVER then
    AddCSLuaFile()

    local gunship = {["npc_combinegunship"] = true, ["npc_combinedropship"] = true}

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

        if self.SpawnTime + self.LifeTime < CurTime() then
            self:Detonate()
            return
        end

        if self:WaterLevel() > 0 then
            self:Detonate()
            return
        end

        local drunk = false

        if self.FireAndForget then
            if self.ShootEntData.Target and IsValid(self.ShootEntData.Target) then
                local target = self.ShootEntData.Target
                if target.UnTrackable then self.ShootEntData.Target = nil end

                local tpos = target:EyePos()
                if self.TopAttack and not self.TopAttackReached then
                    tpos = tpos + Vector(0, 0, self.TopAttackHeight)

                    local dist = (tpos - self:GetPos()):Length()

                    if dist <= 2000 then
                        self.TopAttackReached = true
                        self.SuperSteerTime = CurTime() + self.SuperSteerBoostTime
                    end
                end
                local dir = (tpos - self:GetPos()):GetNormalized()
                local dot = dir:Dot(self:GetAngles():Forward())
                local ang = dir:Angle()

                if self.SuperSeeker or dot >= self.SeekerAngle or not self.TopAttackReached or (self.SuperSteerTime and self.SuperSteerTime >= CurTime()) then
                    local p = self:GetAngles().p
                    local y = self:GetAngles().y

                    p = math.ApproachAngle(p, ang.p, FrameTime() * self.SteerSpeed)
                    y = math.ApproachAngle(y, ang.y, FrameTime() * self.SteerSpeed)

                    self:SetAngles(Angle(p, y, 0))
                    -- self:SetVelocity(dir * 15000)
                elseif self.NoReacquire then
                    self.ShootEntData.Target = nil
                    drunk = true
                end
            end
        end

        if drunk then
            self:GetPhysicsObject():AddAngleVelocity(VectorRand() * FrameTime() * 1500)
            --self:SetAngles(self:GetAngles() + (AngleRand() * FrameTime() * 1000 / 360))
        end

        if self.Drunkenness > 0 then
            self:GetPhysicsObject():AddAngleVelocity(VectorRand() * FrameTime() * self.Drunkenness)
            --self:SetAngles(self:GetAngles() + (AngleRand() * FrameTime() * self.Drunkenness / 360))
        end

        if self.BoostTime + self.SpawnTime > CurTime() then
            local vel = self:GetVelocity():Length()
            if not self.BoostTarget or vel < self.BoostTarget then
                self:GetPhysicsObject():AddVelocity(self:GetForward() * self.Boost)
            end
            self:GetPhysicsObject():AddVelocity(Vector(0, 0, self.Lift))
        end

        local v = self:GetVelocity()
        if v:Length() >= 1000 then
            self:SetAngles(v:Angle())
            self:GetPhysicsObject():SetVelocityInstantaneous(v)
        end

        -- Gunships have no physics collection, periodically trace to try and blow up in their face
        if self.GunshipWorkaround and (self.GunshipCheck or 0 < CurTime()) then
            self.GunshipCheck = CurTime() + 0.33
            local tr = util.TraceLine({
                start = self:GetPos(),
                endpos = self:GetPos() + (self:GetVelocity() * 6 * engine.TickInterval()),
                filter = self,
                mask = MASK_SHOT
            })
            if IsValid(tr.Entity) and gunship[tr.Entity:GetClass()] then
                self:SetPos(tr.HitPos)
                self:Detonate()
            end
        end
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
        if not self:IsValid() then return end

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

    -- Combine Helicopters are hard-coded to only take DMG_AIRBOAT damage
    hook.Add("EntityTakeDamage", "ARC9_HelicopterWorkaround", function(ent, dmginfo)
        if IsValid(ent:GetOwner()) and ent:GetOwner():GetClass() == "npc_helicopter" then ent = ent:GetOwner() end
        if ent:GetClass() == "npc_helicopter" and dmginfo:GetInflictor().HelicopterWorkaround then
            dmginfo:SetDamageType(bit.bor(dmginfo:GetDamageType(), DMG_AIRBOAT))
        end
    end)
end

function ENT:Draw()
    self:DrawModel()
end