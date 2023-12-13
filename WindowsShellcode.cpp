#include <Windows.h>
#include <winternl.h>

#pragma code_seg(".text")

__declspec(allocate(".text"))
char szEthicalBlue[] { "ethical.blue Magazine // Cybersecurity clarified." };

__declspec(allocate(".text"))
char szLoadLibraryA[] { "LoadLibraryA" };

__declspec(allocate(".text"))
char szUser32[] { "user32.dll" };

__declspec(allocate(".text"))
char szMessageBoxA[] { "MessageBoxA" };

__declspec(allocate(".text"))
char szExitProcess[] { "ExitProcess" };

int WINAPI WinMain(_In_ HINSTANCE hInstance,
    _In_opt_ HINSTANCE hPrevInstance,
    _In_ LPSTR lpCmdLine, _In_ int nShowCmd)
{
    PPEB pPEB { };

#if defined(_M_ARM64)
    pPEB = reinterpret_cast<PPEB>(
        __readx18qword(0x60));
#elif defined(_M_X64)
    pPEB = reinterpret_cast<PPEB>(
        __readgsqword(0x60));
#elif defined(_M_IX86)
    pPEB = reinterpret_cast<PPEB>(
        __readfsdword(0x30));
#endif

    PLDR_DATA_TABLE_ENTRY pKernel32Entry =
        reinterpret_cast<PLDR_DATA_TABLE_ENTRY>
        ((PBYTE)(pPEB->Ldr->InMemoryOrderModuleList.Flink->Flink->Flink)
            - (ULONG_PTR)(&((PLDR_DATA_TABLE_ENTRY)0)->InMemoryOrderLinks));

    PIMAGE_DOS_HEADER pKernel32Base =
        reinterpret_cast<PIMAGE_DOS_HEADER>(pKernel32Entry->DllBase);

    PIMAGE_NT_HEADERS pNtHeader
    {
        reinterpret_cast<PIMAGE_NT_HEADERS>(
        (ptrdiff_t)pKernel32Base + pKernel32Base->e_lfanew)
    };

    PIMAGE_EXPORT_DIRECTORY pExports
    {
        reinterpret_cast<PIMAGE_EXPORT_DIRECTORY>(
        (ptrdiff_t)pKernel32Base +
        pNtHeader->OptionalHeader.DataDirectory
            [IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress)
    };

    PDWORD pNames
    {
        reinterpret_cast<PDWORD>(
        (ptrdiff_t)pKernel32Base +
        pExports->AddressOfNames)
    };

    unsigned i { 0 };

    for (i = 0; i < pExports->NumberOfNames; i++)
    {
        if (*(__int64*)((ptrdiff_t)pKernel32Base + pNames[i]) == 0x41636F7250746547)
            break;
    }

    auto pFunctionNameOrdinalOffsets
    {
        reinterpret_cast<__int16*>(
            (ptrdiff_t)pKernel32Base +
            pExports->AddressOfNameOrdinals)
    };

    auto pFunctionOffsets
    {
        reinterpret_cast<__int32*>(
        (ptrdiff_t)pKernel32Base +
        pExports->AddressOfFunctions)
    };

    using GetProcAddressFunc = FARPROC(*)(HMODULE, LPCSTR);

    GetProcAddressFunc pGetProcAddress
    {
        reinterpret_cast<GetProcAddressFunc>((PVOID)(
            (ptrdiff_t)pKernel32Base +
            pFunctionOffsets[pFunctionNameOrdinalOffsets[i]]))
    };

    HMODULE kernel32{ reinterpret_cast<HMODULE>(pKernel32Base) };

    using LoadLibraryAFunc = HMODULE(*)(LPCSTR);

    LoadLibraryAFunc pLoadLibraryA
    {
        reinterpret_cast<LoadLibraryAFunc>(
            pGetProcAddress(kernel32, szLoadLibraryA))
    };

    HMODULE user32{ pLoadLibraryA(szUser32) };

    using MessageBoxAFunc = int(*)(HWND, LPCSTR, LPCSTR, UINT);

    MessageBoxAFunc pMessageBoxA
    {
        reinterpret_cast<MessageBoxAFunc>(
            pGetProcAddress(user32, "MessageBoxA"))
    };

    pMessageBoxA(NULL, szEthicalBlue, szEthicalBlue, MB_OK);

    using ExitProcessFunc = void(*)(UINT);

    ExitProcessFunc pExitProcess
    {
        reinterpret_cast<ExitProcessFunc>(
            pGetProcAddress(kernel32, szExitProcess))
    };

    pExitProcess(0);
}