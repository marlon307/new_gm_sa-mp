#if defined _Neon_included
	#endinput
#endif
#define _Neon_included
#pragma library

/*
native SetVheicleNeon(vehicleid, neonid);
*/

new bool:NeonALready[MAX_VEHICLES][6];
new Neon[MAX_VEHICLES][12];

stock SetVheicleNeon(vehicleid, neonid)
{
	if(neonid == 0)
	{
		if(NeonALready[vehicleid][0] == false)
		{
			NeonALready[vehicleid][0] = true;
			NeonALready[vehicleid][1] = false;
			NeonALready[vehicleid][2] = false;
			NeonALready[vehicleid][3] = false;
			NeonALready[vehicleid][4] = false;
			NeonALready[vehicleid][5] = false;

			if(IsValidDynamicObject(Neon[vehicleid][2]) &&
				IsValidDynamicObject(Neon[vehicleid][3]))
			{
				DestroyDynamicObject(Neon[vehicleid][2]);
				DestroyDynamicObject(Neon[vehicleid][3]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][4]) &&
				IsValidDynamicObject(Neon[vehicleid][5]))
			{
				DestroyDynamicObject(Neon[vehicleid][4]);
				DestroyDynamicObject(Neon[vehicleid][5]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][6]) &&
				IsValidDynamicObject(Neon[vehicleid][7]))
			{
				DestroyDynamicObject(Neon[vehicleid][6]);
				DestroyDynamicObject(Neon[vehicleid][7]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][8]) &&
				IsValidDynamicObject(Neon[vehicleid][9]))
			{
				DestroyDynamicObject(Neon[vehicleid][8]);
				DestroyDynamicObject(Neon[vehicleid][9]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][10]) &&
				IsValidDynamicObject(Neon[vehicleid][11]))
			{
				DestroyDynamicObject(Neon[vehicleid][10]);
				DestroyDynamicObject(Neon[vehicleid][11]);
			}
			Neon[vehicleid][0] = CreateDynamicObject(18648, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			Neon[vehicleid][1] = CreateDynamicObject(18648, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			AttachDynamicObjectToVehicle(Neon[vehicleid][0], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			AttachDynamicObjectToVehicle(Neon[vehicleid][1], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
		}
	}
	if(neonid == 1)
	{
		if(NeonALready[vehicleid][1] == false)
		{
			NeonALready[vehicleid][0] = false;
			NeonALready[vehicleid][1] = true;
			NeonALready[vehicleid][2] = false;
			NeonALready[vehicleid][3] = false;
			NeonALready[vehicleid][4] = false;
			NeonALready[vehicleid][5] = false;

			if(IsValidDynamicObject(Neon[vehicleid][0]) &&
				IsValidDynamicObject(Neon[vehicleid][1]))
			{
				DestroyDynamicObject(Neon[vehicleid][0]);
				DestroyDynamicObject(Neon[vehicleid][1]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][4]) &&
				IsValidDynamicObject(Neon[vehicleid][5]))
			{
				DestroyDynamicObject(Neon[vehicleid][4]);
				DestroyDynamicObject(Neon[vehicleid][5]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][6]) &&
				IsValidDynamicObject(Neon[vehicleid][7]))
			{
				DestroyDynamicObject(Neon[vehicleid][6]);
				DestroyDynamicObject(Neon[vehicleid][7]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][8]) &&
				IsValidDynamicObject(Neon[vehicleid][9]))
			{
				DestroyDynamicObject(Neon[vehicleid][8]);
				DestroyDynamicObject(Neon[vehicleid][9]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][10]) &&
				IsValidDynamicObject(Neon[vehicleid][11]))
			{
				DestroyDynamicObject(Neon[vehicleid][10]);
				DestroyDynamicObject(Neon[vehicleid][11]);
			}
			Neon[vehicleid][2] = CreateDynamicObject(18649, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			Neon[vehicleid][3] = CreateDynamicObject(18649, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			AttachDynamicObjectToVehicle(Neon[vehicleid][2], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			AttachDynamicObjectToVehicle(Neon[vehicleid][3], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
		}
	}
	if(neonid == 2)
	{
		if(NeonALready[vehicleid][2] == false)
		{
			NeonALready[vehicleid][0] = false;
			NeonALready[vehicleid][1] = false;
			NeonALready[vehicleid][2] = true;
			NeonALready[vehicleid][3] = false;
			NeonALready[vehicleid][4] = false;
			NeonALready[vehicleid][5] = false;

			if(IsValidDynamicObject(Neon[vehicleid][0]) &&
				IsValidDynamicObject(Neon[vehicleid][1]))
			{
				DestroyDynamicObject(Neon[vehicleid][0]);
				DestroyDynamicObject(Neon[vehicleid][1]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][2]) &&
				IsValidDynamicObject(Neon[vehicleid][3]))
			{
				DestroyDynamicObject(Neon[vehicleid][2]);
				DestroyDynamicObject(Neon[vehicleid][3]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][6]) &&
				IsValidDynamicObject(Neon[vehicleid][7]))
			{
				DestroyDynamicObject(Neon[vehicleid][6]);
				DestroyDynamicObject(Neon[vehicleid][7]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][8]) &&
				IsValidDynamicObject(Neon[vehicleid][9]))
			{
				DestroyDynamicObject(Neon[vehicleid][8]);
				DestroyDynamicObject(Neon[vehicleid][9]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][10]) &&
				IsValidDynamicObject(Neon[vehicleid][11]))
			{
				DestroyDynamicObject(Neon[vehicleid][10]);
				DestroyDynamicObject(Neon[vehicleid][11]);
			}
			Neon[vehicleid][4] = CreateDynamicObject(18647, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			Neon[vehicleid][5] = CreateDynamicObject(18647, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			AttachDynamicObjectToVehicle(Neon[vehicleid][4], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			AttachDynamicObjectToVehicle(Neon[vehicleid][5], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
		}
	}
	if(neonid == 3)
	{
		if(NeonALready[vehicleid][3] == false)
		{
			NeonALready[vehicleid][0] = false;
			NeonALready[vehicleid][1] = false;
			NeonALready[vehicleid][2] = false;
			NeonALready[vehicleid][3] = true;
			NeonALready[vehicleid][4] = false;
			NeonALready[vehicleid][5] = false;

			if(IsValidDynamicObject(Neon[vehicleid][0]) &&
				IsValidDynamicObject(Neon[vehicleid][1]))
			{
				DestroyDynamicObject(Neon[vehicleid][0]);
				DestroyDynamicObject(Neon[vehicleid][1]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][2]) &&
				IsValidDynamicObject(Neon[vehicleid][3]))
			{
				DestroyDynamicObject(Neon[vehicleid][2]);
				DestroyDynamicObject(Neon[vehicleid][3]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][4]) &&
				IsValidDynamicObject(Neon[vehicleid][5]))
			{
				DestroyDynamicObject(Neon[vehicleid][4]);
				DestroyDynamicObject(Neon[vehicleid][5]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][8]) &&
				IsValidDynamicObject(Neon[vehicleid][9]))
			{
				DestroyDynamicObject(Neon[vehicleid][8]);
				DestroyDynamicObject(Neon[vehicleid][9]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][10]) &&
				IsValidDynamicObject(Neon[vehicleid][11]))
			{
				DestroyDynamicObject(Neon[vehicleid][10]);
				DestroyDynamicObject(Neon[vehicleid][11]);
			}
			Neon[vehicleid][6] = CreateDynamicObject(18650, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			Neon[vehicleid][7] = CreateDynamicObject(18650, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			AttachDynamicObjectToVehicle(Neon[vehicleid][6], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			AttachDynamicObjectToVehicle(Neon[vehicleid][7], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
		}
	}
	if(neonid == 4)
	{
		if(NeonALready[vehicleid][4] == false)
		{
			NeonALready[vehicleid][0] = false;
			NeonALready[vehicleid][1] = false;
			NeonALready[vehicleid][2] = false;
			NeonALready[vehicleid][3] = false;
			NeonALready[vehicleid][4] = true;
			NeonALready[vehicleid][5] = false;

			if(IsValidDynamicObject(Neon[vehicleid][0]) &&
				IsValidDynamicObject(Neon[vehicleid][1]))
			{
				DestroyDynamicObject(Neon[vehicleid][0]);
				DestroyDynamicObject(Neon[vehicleid][1]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][2]) &&
				IsValidDynamicObject(Neon[vehicleid][3]))
			{
				DestroyDynamicObject(Neon[vehicleid][2]);
				DestroyDynamicObject(Neon[vehicleid][3]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][4]) &&
				IsValidDynamicObject(Neon[vehicleid][5]))
			{
				DestroyDynamicObject(Neon[vehicleid][4]);
				DestroyDynamicObject(Neon[vehicleid][5]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][6]) &&
				IsValidDynamicObject(Neon[vehicleid][7]))
			{
				DestroyDynamicObject(Neon[vehicleid][6]);
				DestroyDynamicObject(Neon[vehicleid][7]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][10]) &&
				IsValidDynamicObject(Neon[vehicleid][11]))
			{
				DestroyDynamicObject(Neon[vehicleid][10]);
				DestroyDynamicObject(Neon[vehicleid][11]);
			}
			Neon[vehicleid][8] = CreateDynamicObject(18652, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			Neon[vehicleid][9] = CreateDynamicObject(18652, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			AttachDynamicObjectToVehicle(Neon[vehicleid][8], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			AttachDynamicObjectToVehicle(Neon[vehicleid][9], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
		}
	}
	if(neonid == 5)
	{
		if(NeonALready[vehicleid][5] == false)
		{
			NeonALready[vehicleid][0] = false;
			NeonALready[vehicleid][1] = false;
			NeonALready[vehicleid][2] = false;
			NeonALready[vehicleid][3] = false;
			NeonALready[vehicleid][4] = false;
			NeonALready[vehicleid][5] = true;

			if(IsValidDynamicObject(Neon[vehicleid][0]) &&
				IsValidDynamicObject(Neon[vehicleid][1]))
			{
				DestroyDynamicObject(Neon[vehicleid][0]);
				DestroyDynamicObject(Neon[vehicleid][1]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][2]) &&
				IsValidDynamicObject(Neon[vehicleid][3]))
			{
				DestroyDynamicObject(Neon[vehicleid][2]);
				DestroyDynamicObject(Neon[vehicleid][3]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][4]) &&
				IsValidDynamicObject(Neon[vehicleid][5]))
			{
				DestroyDynamicObject(Neon[vehicleid][4]);
				DestroyDynamicObject(Neon[vehicleid][5]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][6]) &&
				IsValidDynamicObject(Neon[vehicleid][7]))
			{
				DestroyDynamicObject(Neon[vehicleid][6]);
				DestroyDynamicObject(Neon[vehicleid][7]);
			}
			if(IsValidDynamicObject(Neon[vehicleid][8]) &&
				IsValidDynamicObject(Neon[vehicleid][9]))
			{
				DestroyDynamicObject(Neon[vehicleid][8]);
				DestroyDynamicObject(Neon[vehicleid][9]);
			}
			Neon[vehicleid][10] = CreateDynamicObject(18651, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			Neon[vehicleid][11] = CreateDynamicObject(18651, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0);
			AttachDynamicObjectToVehicle(Neon[vehicleid][10], vehicleid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			AttachDynamicObjectToVehicle(Neon[vehicleid][11], vehicleid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
		}
	}
	if(neonid == 6)
	{
		if(IsValidDynamicObject(Neon[vehicleid][0]) &&
			IsValidDynamicObject(Neon[vehicleid][1]))
		{
			DestroyDynamicObject(Neon[vehicleid][0]);
			DestroyDynamicObject(Neon[vehicleid][1]);
		}
		if(IsValidDynamicObject(Neon[vehicleid][2]) &&
			IsValidDynamicObject(Neon[vehicleid][3]))
		{
			DestroyDynamicObject(Neon[vehicleid][2]);
			DestroyDynamicObject(Neon[vehicleid][3]);
		}
		if(IsValidDynamicObject(Neon[vehicleid][4]) &&
			IsValidDynamicObject(Neon[vehicleid][5]))
		{
			DestroyDynamicObject(Neon[vehicleid][4]);
			DestroyDynamicObject(Neon[vehicleid][5]);
		}
		if(IsValidDynamicObject(Neon[vehicleid][6]) &&
			IsValidDynamicObject(Neon[vehicleid][7]))
		{
			DestroyDynamicObject(Neon[vehicleid][6]);
			DestroyDynamicObject(Neon[vehicleid][7]);
		}
		if(IsValidDynamicObject(Neon[vehicleid][8]) &&
			IsValidDynamicObject(Neon[vehicleid][9]))
		{
			DestroyDynamicObject(Neon[vehicleid][8]);
			DestroyDynamicObject(Neon[vehicleid][9]);
		}
		if(IsValidDynamicObject(Neon[vehicleid][10]) &&
			IsValidDynamicObject(Neon[vehicleid][11]))
		{
			DestroyDynamicObject(Neon[vehicleid][10]);
			DestroyDynamicObject(Neon[vehicleid][11]);
		}
	}
	return 1;
}
