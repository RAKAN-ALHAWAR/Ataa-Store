part of '../../widget.dart';

class BankCardX extends StatelessWidget {
  const BankCardX({super.key, required this.bank});
  final BankX bank;
  @override
  Widget build(BuildContext context) {
    return ContainerX(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      margin: const EdgeInsets.only(bottom: 14.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          ContainerX(
            width: 140,
            height: 80,
            radius: 12,
            isBorder: true,
            borderWidth: 0.5,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            color: context.isDarkMode ? Colors.white : null,
            child: Center(
              child: Theme(
                data: ThemeX.light,
                child: ImageNetworkX(
                  imageUrl: bank.imageUrl,
                  height: 50,
                  fit: BoxFit.contain,
                  backgroundLoading: Colors.transparent,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          TextX(
            bank.name,
            style: TextStyleX.headerSmall,
          ),
          const SizedBox(height: 12),
          TextX(
            "Bank Account Numbers (IBAN)",
            style: TextStyleX.titleSmall,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(height: 12),
          for(BankAccountX bankAccount in bank.bankAccounts)
          InkWell(
            onTap: () async => ClipboardX.copy(bankAccount.iban),
            child: ContainerX(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
              isBorder: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextX(
                          bankAccount.name,
                          style: TextStyleX.titleSmall,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(height: 6),
                        TextX(
                          bankAccount.iban,
                          style: TextStyleX.titleSmall,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                   Icon(
                    IconX.copy,
                    color: Theme.of(context).primaryColor,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
