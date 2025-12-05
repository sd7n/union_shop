import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class AccountDashboardPage extends StatelessWidget {
  const AccountDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final user = authProvider.currentUser;

        if (user == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Account'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.account_circle, size: 100, color: Colors.grey),
                  const SizedBox(height: 24),
                  const Text(
                    'Please sign in to view your account',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4D2963),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 16,
                      ),
                    ),
                    child: const Text('Sign In'),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('My Account'),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await authProvider.signOut();
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, '/');
                  }
                },
                tooltip: 'Sign Out',
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(context, user, authProvider),
                const SizedBox(height: 32),
                _buildSectionTitle(context, 'Account Information'),
                const SizedBox(height: 16),
                _buildInfoCard(context, user),
                const SizedBox(height: 32),
                _buildSectionTitle(context, 'Quick Actions'),
                const SizedBox(height: 16),
                _buildQuickActions(context, authProvider),
                const SizedBox(height: 32),
                _buildSectionTitle(context, 'Orders & Activity'),
                const SizedBox(height: 16),
                _buildActivityCard(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileHeader(
      BuildContext context, user, AuthProvider authProvider) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: const Color(0xFF4D2963),
              backgroundImage:
                  user.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
              child: user.photoUrl == null
                  ? Text(
                      user.displayName?.substring(0, 1).toUpperCase() ?? 'U',
                      style: const TextStyle(fontSize: 32, color: Colors.white),
                    )
                  : null,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.displayName ?? 'User',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.email,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/edit-profile');
                    },
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text('Edit Profile'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4D2963),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildInfoCard(BuildContext context, user) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInfoRow(Icons.email, 'Email', user.email),
            if (user.phoneNumber != null) ...[
              const Divider(),
              _buildInfoRow(Icons.phone, 'Phone', user.phoneNumber!),
            ],
            if (user.address != null) ...[
              const Divider(),
              _buildInfoRow(Icons.home, 'Address', user.address!),
            ],
            if (user.city != null && user.postcode != null) ...[
              const Divider(),
              _buildInfoRow(Icons.location_city, 'City',
                  '${user.city}, ${user.postcode}'),
            ],
            if (user.country != null) ...[
              const Divider(),
              _buildInfoRow(Icons.public, 'Country', user.country!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF4D2963), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, AuthProvider authProvider) {
    return Column(
      children: [
        _buildActionButton(
          context,
          Icons.shopping_bag,
          'My Orders',
          'View order history',
          () {
            // Navigate to orders page
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Orders page coming soon!'),
                backgroundColor: Color(0xFF4D2963),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildActionButton(
          context,
          Icons.favorite,
          'Wishlist',
          'Saved items',
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Wishlist feature coming soon!'),
                backgroundColor: Color(0xFF4D2963),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildActionButton(
          context,
          Icons.location_on,
          'Addresses',
          'Manage delivery addresses',
          () {
            Navigator.pushNamed(context, '/edit-profile');
          },
        ),
        const SizedBox(height: 12),
        _buildActionButton(
          context,
          Icons.lock,
          'Change Password',
          'Update your password',
          () {
            _showChangePasswordDialog(context, authProvider);
          },
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String title,
      String subtitle, VoidCallback onTap) {
    return Card(
      elevation: 1,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF4D2963).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF4D2963)),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Widget _buildActivityCard(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatItem(context, '0', 'Orders'),
                _buildStatItem(context, '0', 'Wishlist'),
                _buildStatItem(context, '0', 'Reviews'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4D2963),
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }

  void _showChangePasswordDialog(
      BuildContext context, AuthProvider authProvider) {
    final emailController = TextEditingController(
      text: authProvider.currentUser?.email,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'A password reset link will be sent to your email address.',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final success =
                  await authProvider.resetPassword(emailController.text);
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success
                          ? 'Password reset link sent to your email'
                          : authProvider.errorMessage ?? 'Failed to send reset link',
                    ),
                    backgroundColor:
                        success ? const Color(0xFF4D2963) : Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4D2963),
              foregroundColor: Colors.white,
            ),
            child: const Text('Send Reset Link'),
          ),
        ],
      ),
    );
  }
}
