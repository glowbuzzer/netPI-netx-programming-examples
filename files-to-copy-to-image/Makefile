GCC = gcc
CFLAGS =
SRCPATH = .
LIBS = -lcifx
OBJDIR = ./objs
SOURCES = $(SRCPATH)/sources
INCDIRS = -I/usr/include/cifx -Iincludes/PROFINET -Iincludes/EtherNetIP -Iincludes/

all:						$(SRCPATH)/PNS_simpleConfig $(SRCPATH)/EIS_simpleConfig


$(SRCPATH)/PNS_simpleConfig:			$(OBJDIR)/PNS_simpleConfig.o $(OBJDIR)/SystemPackets.o $(OBJDIR)/PacketHandlerPNS.o 
						$(GCC) $(LIBS) -o $(SRCPATH)/PNS_simpleConfig $(OBJDIR)/PNS_simpleConfig.o $(OBJDIR)/SystemPackets.o $(OBJDIR)/PacketHandlerPNS.o

$(SRCPATH)/EIS_simpleConfig:			$(OBJDIR)/EIS_simpleConfig.o $(OBJDIR)/SystemPackets.o $(OBJDIR)/PacketHandlerEIS.o 
						$(GCC) $(LIBS) -o $(SRCPATH)/EIS_simpleConfig $(OBJDIR)/EIS_simpleConfig.o $(OBJDIR)/SystemPackets.o $(OBJDIR)/PacketHandlerEIS.o


$(OBJDIR)/PNS_simpleConfig.o:			$(SOURCES)/PNS_simpleConfig.c
						$(GCC) $(CFLAGS) -c $(SOURCES)/PNS_simpleConfig.c -o $(OBJDIR)/PNS_simpleConfig.o $(INCDIRS)

$(OBJDIR)/EIS_simpleConfig.o:			$(SOURCES)/EIS_simpleConfig.c
						$(GCC) $(CFLAGS) -c $(SOURCES)/EIS_simpleConfig.c -o $(OBJDIR)/EIS_simpleConfig.o $(INCDIRS)

$(OBJDIR)/SystemPackets.o:			$(SOURCES)/SystemPackets.c
						$(GCC) $(CFLAGS) -c $(SOURCES)/SystemPackets.c -o $(OBJDIR)/SystemPackets.o $(INCDIRS)

$(OBJDIR)/PacketHandlerPNS.o:			$(SOURCES)/PacketHandlerPNS.c
						$(GCC) $(CFLAGS) -c $(SOURCES)/PacketHandlerPNS.c -o $(OBJDIR)/PacketHandlerPNS.o $(INCDIRS)

$(OBJDIR)/PacketHandlerEIS.o:			$(SOURCES)/PacketHandlerEIS.c
						$(GCC) $(CFLAGS) -c $(SOURCES)/PacketHandlerEIS.c -o $(OBJDIR)/PacketHandlerEIS.o $(INCDIRS)



clean:
						rm $(OBJDIR)/*.o

