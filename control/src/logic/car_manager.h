#ifndef CAR_MANAGER_H
#define CAR_MANAGER_H

#include "../components/infra_red.h"

class CarManager
{
private:
    InfraRed &infraRedIn;
    InfraRed &infraRedOut;
    int numCars;
    bool lastInDetected;
    bool lastOutDetected;

public:
    CarManager(InfraRed &in, InfraRed &out)
        : infraRedIn(in), infraRedOut(out)
    {
        numCars = 0;
        lastInDetected = false;
        lastOutDetected = false;
    }

    void update()
    {
        checkCarEntry();
        checkCarExit();
    }

    int getCarCount() const
    {
        return numCars;
    }

    void setCarCount(int count)
    {
        numCars = count;
    }

private:
    void checkCarEntry()
    {
        bool inDetected = infraRedIn.isDetected();
        if (inDetected && !lastInDetected)
        {
            numCars++;
        }
        lastInDetected = inDetected;
    }

    void checkCarExit()
    {
        bool outDetected = infraRedOut.isDetected();
        if (outDetected && !lastOutDetected)
        {
            if (numCars > 0)
            {
                numCars--;
            }
        }
        lastOutDetected = outDetected;
    }
};

#endif