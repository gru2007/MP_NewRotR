class config_aissp
{
	class settings
	{
		//TODO: something fancy
	};
	class classPresets
	{

		///CUSTOM CLASS EXAMPLE - You can copy-paste more customClasses and fill them as you will, just remember to rename them individually
		class CIS
		{
			side = 2; //0 = CIV, 1 = BLU, 2 = OPF, 3 = IND
			men[] = {"JLTS_Droid_B1_AT","JLTS_Droid_B1_E5"};
			divers[] = {"JLTS_Droid_B1_Crew"};
			cars[] = {"3as_SAC_Trade"};
			tanks[] = {"3AS_AAT"};
			helicopters[] = {"ls_cis_hmp_transport"};
			planes[] = {"3as_Vulture_dynamicLoadout"};
		};

		class ambientExplosionsPlanes
		{
			side = 2;
			men[] = {""};
			men2[] = {""};
			men3[] = {""};
			menSF[] = {""};
			divers[] = {""};
			cars[] = {""};
			tanks[] = {""};
			helicopters[] = {""};
			planes[] = {"B_Plane_CAS_01_Cluster_F"};
			ships[] = {""};
		};

		//DEFAULT TEMPLATES. Modify only if you know what you are doing.
		class CIV
		{
			side = 0;
			men[] = {"JLTS_Droid_B1_AT","JLTS_Droid_B1_E5"};
			divers[] = {"JLTS_Droid_B1_Crew"};
			cars[] = {"3as_SAC_Trade"};
			tanks[] = {"3AS_AAT"};
			helicopters[] = {"ls_cis_hmp_transport"};
			planes[] = {"3as_Vulture_dynamicLoadout"};
		};
		class BLU_CTRG
		{
			side = 1;
			men[] = {"JLTS_Droid_B1_AT","JLTS_Droid_B1_E5"};
			divers[] = {"JLTS_Droid_B1_Crew"};
			cars[] = {"3as_SAC_Trade"};
			tanks[] = {"3AS_AAT"};
			helicopters[] = {"ls_cis_hmp_transport"};
			planes[] = {"3as_Vulture_dynamicLoadout"};
		};
		class BLU_F
		{
			side = 1;
			men[] = {"JLTS_Droid_B1_AT","JLTS_Droid_B1_E5"};
			divers[] = {"JLTS_Droid_B1_Crew"};
			cars[] = {"3as_SAC_Trade"};
			tanks[] = {"3AS_AAT"};
			helicopters[] = {"ls_cis_hmp_transport"};
			planes[] = {"3as_Vulture_dynamicLoadout"};
		};
		class BLU_G_F
		{
			side = 1;
			men[] = {"JLTS_Droid_B1_AT","JLTS_Droid_B1_E5"};
			divers[] = {"JLTS_Droid_B1_Crew"};
			cars[] = {"3as_SAC_Trade"};
			tanks[] = {"3AS_AAT"};
			helicopters[] = {"ls_cis_hmp_transport"};
			planes[] = {"3as_Vulture_dynamicLoadout"};
		};
		class BLU_GEN_F
		{
			side = 1;
			cars[] = {"B_GEN_Offroad_01_gen_F"};
			men[] = {"B_GEN_Soldier_F","B_GEN_Commander_F"};
		};
		class BLU_T_F
		{
			side = 1;
			men[] = {"JLTS_Droid_B1_AT","JLTS_Droid_B1_E5"};
			divers[] = {"JLTS_Droid_B1_Crew"};
			cars[] = {"3as_SAC_Trade"};
			tanks[] = {"3AS_AAT"};
			helicopters[] = {"ls_cis_hmp_transport"};
			planes[] = {"3as_Vulture_dynamicLoadout"};
		};
		class IND_C_F
		{
			side = 3;
			men[] = {"JLTS_Droid_B1_AT","JLTS_Droid_B1_E5"};
			divers[] = {"JLTS_Droid_B1_Crew"};
			cars[] = {"3as_SAC_Trade"};
			tanks[] = {"3AS_AAT"};
			helicopters[] = {"ls_cis_hmp_transport"};
			planes[] = {"3as_Vulture_dynamicLoadout"};
		};
		class IND_F
		{
			side = 3;
			men[] = {"JLTS_Droid_B1_AT","JLTS_Droid_B1_E5"};
			divers[] = {"JLTS_Droid_B1_Crew"};
			cars[] = {"3as_SAC_Trade"};
			tanks[] = {"3AS_AAT"};
			helicopters[] = {"ls_cis_hmp_transport"};
			planes[] = {"3as_Vulture_dynamicLoadout"};
		};
		class IND_G_F
		{
			side = 3;
			men[] = {"JLTS_Droid_B1_AT","JLTS_Droid_B1_E5"};
			divers[] = {"JLTS_Droid_B1_Crew"};
			cars[] = {"3as_SAC_Trade"};
			tanks[] = {"3AS_AAT"};
			helicopters[] = {"ls_cis_hmp_transport"};
			planes[] = {"3as_Vulture_dynamicLoadout"};
		};
		class OPF_F
		{
			side = 2;
			men[] = {"JLTS_Droid_B1_AT","JLTS_Droid_B1_E5"};
			divers[] = {"JLTS_Droid_B1_Crew"};
			cars[] = {"3as_SAC_Trade"};
			tanks[] = {"3AS_AAT"};
			helicopters[] = {"ls_cis_hmp_transport"};
			planes[] = {"3as_Vulture_dynamicLoadout"};
		};
		class OPF_G_F
		{
			side = 2;
			men[] = {"JLTS_Droid_B1_AT","JLTS_Droid_B1_E5"};
			divers[] = {"JLTS_Droid_B1_Crew"};
			cars[] = {"3as_SAC_Trade"};
			tanks[] = {"3AS_AAT"};
			helicopters[] = {"ls_cis_hmp_transport"};
			planes[] = {"3as_Vulture_dynamicLoadout"};
		};
		class OPF_T_F
		{
			side = 2;
			men[] = {"JLTS_Droid_B1_AT","JLTS_Droid_B1_E5"};
			divers[] = {"JLTS_Droid_B1_Crew"};
			cars[] = {"3as_SAC_Trade"};
			tanks[] = {"3AS_AAT"};
			helicopters[] = {"ls_cis_hmp_transport"};
			planes[] = {"3as_Vulture_dynamicLoadout"};
		};

	};
};