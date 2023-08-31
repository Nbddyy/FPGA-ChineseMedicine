{
    unsigned char i = 0;
    Uart_Init();
    Delay_ms(10);
    UartPrintf("Welcome to use!");
    clrStruct();    //清空缓存数组

}

void parseGpsBuffer() {
    char *subString;
    char *subStringNext;
    char i = 0;
    if(Save_Data.isGetData) 
    {
        Save_Data.isGetData = false;
        UartPrintf("***************\r\n");
        UartPrintf(Save_Data.GPS_Buffer);

        for(i = 0; i < 6; i++) 
        {
            if(i == 0) 
            {
                if((subString = strstr(Save_Data.GPS_Buffer,",")) == NULL)
                    errorLog(1);    //解析错误
            } else
            {
                subString++;
                if((subStringNext = strstr(subString,",")) != NULL)
                {
                    char usefullBuffer[2];
                    switch(i)
                    {
                        case 1: memcpy(Save_Data.UTCTime,subStringNext - subString);break;  //获取UTC时间
                        case 2: memcpy(usefullBuffer,subStringNext - subString);break;  //获取UTC时间
                        case 3: memcpy(Save_Data.latitude,subString,subStringNext - subString);break;  //获取纬度信息
                        case 4: memcpy(Save_Data.N_S,subString,subStringNext - subString);break;  //N/S
                        case 5: memcpy(Save_Data.longitude,subString,subStringNext - subString);break;  //获取经度信息
                        case 6: memcpy(Save_Data.E_W,subString,subStringNext - subString);break;  //获取E/W
                        default : break;
                    }

                    subString = subStringNext;
                    Save_Data.isParseData = true;
                    if(usefullBuffer[0] == 'A')
                        Save_Data.isUsefull = true;
                    else if(usefullBuffer[0] == 'V')
                        Save_Data.isUsefull = false;
                }
            }
        }
    }
}    

void printGpsBuffer()
{
    if(Save_Data.isParseData)
    {
        Save_Data.isParseData = false;

        UartPrintf("Save_Data.UTCTime = ");
        UartPrintf(Save_Data.UTCTime);
        UartPrintf("\r\n");

        if(Save_Data.isUsefull)
        {
            Save_Data.isUsefull = false;
            UartPrintf("Save_Data.latitude = ");
            UartPrintf(Save_Data.latitude);
            UartPrintf("\r\n");

            UartPrintf("Save_Data.N_S = ");
            UartPrintf(Save_Data.N_S);
            UartPrintf("\r\n");

            UartPrintf("Save_Data.longitude = ");
            UartPrintf(Save_Data.longitude);
            UartPrintf("\r\n");

            UartPrintf("Save_Data.E_W = ");
            UartPrintf(Save_Data.E_W);
            UartPrintf("\r\n");
        } else
        {
            UartPrintf("GPS DATA is not usefull! \r\n");
        }
    }
}