#include <iostream>
#include <cstdlib>
#include "PhotoModel.h"
#include "PhotoModelFactory.h"
#include "NormModel.h"
#include "NormModelFactory.h"
#include "Pvl.h"
#include "PvlGroup.h"
#include "IException.h"
#include "Preference.h"

using namespace Isis;

int main() {
  Isis::Preference::Preferences(true);

  double result;
  double mult;
  double base;

  std::cout << "UNIT TEST for Shade normalization function" << std::endl << std::endl;

  PvlGroup algp("Algorithm");
  algp += PvlKeyword("Name", "Lambert");

  PvlObject op("PhotometricModel");
  op.addGroup(algp);

  PvlGroup algn("Algorithm");
  algn += PvlKeyword("Name", "Shade");
  algn += PvlKeyword("Albedo", ".0690507");

  PvlObject on("NormalizationModel");
  on.addGroup(algn);

  Pvl pvl;
  pvl.addObject(op);
  pvl.addObject(on);

  std::cout << pvl << std::endl << std::endl;

  try {
    PhotoModel *pm = PhotoModelFactory::Create(pvl);
    NormModel *nm = NormModelFactory::Create(pvl, *pm);

    nm->CalcNrmAlbedo(86.7226722, 51.7002388, 38.9414439, 51.7002388, 38.9414439, .0800618902, result, mult, base);

    std::cout << "Test phase=86.7226722, incidence=51.7002388, emission=38.9414439, dn=.0800618902 ..." << std::endl;
    std::cout << "Normalization value = " << result << std::endl << std::endl;

    nm->CalcNrmAlbedo(86.7207248, 51.7031305, 38.9372914, 51.7031305, 38.9372914, .0797334611, result, mult, base);

    std::cout << "Test phase=86.7207248, incidence=51.7031305, emission=38.9372914, dn=.0797334611 ..." << std::endl;
    std::cout << "Normalization value = " << result << std::endl << std::endl;

    nm->CalcNrmAlbedo(86.7187773, 51.7060221, 38.9331391, 51.7060221, 38.9331391, .0794225037, result, mult, base);

    std::cout << "Test phase=86.7187773, incidence=51.7060221, emission=38.9331391, dn=.0794225037 ..." << std::endl;
    std::cout << "Normalization value = " << result << std::endl << std::endl;

  }
  catch(IException &e) {
    e.print();
  }

  return 0;
}
