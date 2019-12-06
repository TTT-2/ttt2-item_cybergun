if SERVER then
	AddCSLuaFile()

	resource.AddFile('materials/vgui/ttt/icon_ct')
	resource.AddFile('sound/emdrive.wav')
	resource.AddFile('sound/emgod.wav')
end

SWEP.PrintName = 'Cybergun'
SWEP.Author = 'Mineotopia'
SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.Base = 'weapon_tttbase'

SWEP.Kind = WEAPON_EXTRA
SWEP.CanBuy = {ROLE_TRAITOR, ROLE_DETECTIVE}
SWEP.InLoadoutFor = nil
SWEP.LimitedStock = true

SWEP.AllowDrop = true
SWEP.IsSilent = false
SWEP.NoSights = false
SWEP.UseHands = true
SWEP.AutoSpawnable = false
SWEP.HoldType = 'pistol'

SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = 'none'

SWEP.Weight = 7
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = true

SWEP.ViewModel = 'models/weapons/v_pist_deagle.mdl'
SWEP.WorldModel = 'models/weapons/w_pist_deagle.mdl'

if CLIENT then
	hook.Add('Initialize', 'ttt2_cybergun_init_language', function()
		LANG.AddToLanguage('English', 'ttt2_weapon_cybergun', 'Cybergun')
		LANG.AddToLanguage('Deutsch', 'ttt2_weapon_cybergun', 'Cybergun')

		LANG.AddToLanguage('English', 'ttt2_weapon_cybergun_desc', 'Shoot a Tesla cybercar at your enemy!')
		LANG.AddToLanguage('Deutsch', 'ttt2_weapon_cybergun_desc', 'Schieße einen Tesla Cybertruck auf deinen Feind!')
	end)

	SWEP.Author = 'Mineotopia'

	SWEP.ViewModelFOV = 54
	SWEP.ViewModelFlip = true

	SWEP.Icon = 'vgui/ttt/icon_ct'
	SWEP.EquipMenuData = {
		type = 'item_weapon',
		name = 'ttt2_weapon_cybergun',
		desc = 'ttt2_weapon_cybergun_desc'
	}
end

sound.Add({
	name = 'cybergun_drive',
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 140,
	sound = 'emdrive.wav'
})

sound.Add({
	name = 'cybergun_special',
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 120,
	sound = 'emgod.wav'
})

function SWEP:Precache()
	util.PrecacheSound('cybergun_special')
	util.PrecacheSound('cybergun_drive')
end

function SWEP:PrimaryAttack()
	self:EmitSound('cybergun_special')

	if CLIENT then return end

	local ent = ents.Create('ent_ttt_cybergun')

	if not IsValid(ent) then return end

	ent:SetPos(self.Owner:EyePos() + self.Owner:GetAimVector() * 200)
	ent:SetAngles(self.Owner:EyeAngles())
	ent:SetOwner(self.Owner)

	ent.SWEP = self

	ent.Sound = 'cybergun_drive'

	ent:Spawn()

	self:Remove()
end
